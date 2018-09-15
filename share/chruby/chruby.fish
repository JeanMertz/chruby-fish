# The MIT License (MIT)
#
# Copyright (c) Jean Mertz <jean@mertz.fm>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

set -gx CHRUBY_FISH_VERSION '0.8.2'

#
# Execute chruby commands through bash.
#
# This method allows any command to be executed through the bash interpreter,
# allowing us to use the original chruby implementation while overlaying a thin
# wrapper on top of it to set ENV variables in the Fish shell.
#
# You can optionally set the $CHRUBY_ROOT environment variable if your
# `chruby.sh` is located in a custom path.
#
function bchruby
  set -q CHRUBY_ROOT; or set CHRUBY_ROOT /usr/local

  if test ! -f "$CHRUBY_ROOT/share/chruby/chruby.sh";
    echo "$CHRUBY_ROOT/share/chruby/chruby.sh does not exist." \
         "Set \$CHRUBY_ROOT to point to the correct path." \
         "(currently pointing to `$CHRUBY_ROOT`)"
    return 1
  end

  set bash_path (env | grep '^PATH=' | cut -c 6-)
  env - HOME="$HOME"           \
        PREFIX="$PREFIX"       \
        PATH="$bash_path"      \
        RUBY_ROOT="$RUBY_ROOT" \
        GEM_HOME="$GEM_HOME"   \
        GEM_ROOT="$GEM_ROOT"   \
        GEM_PATH="$GEM_PATH"   \
        bash -lc "source \"$CHRUBY_ROOT/share/chruby/chruby.sh\"; $argv"
end

# Define RUBIES variable with paths to installed ruby versions.
#
# Gets its list of Rubies from `bchruby`, then adds it to the local RUBIES env.
#
set -gx RUBIES (bchruby 'echo ${RUBIES[@]}' | tr ' ' '\n')
set -gx CHRUBY_VERSION (bchruby 'echo $CHRUBY_VERSION')

#
# Reset chruby-set environment variables.
#
# Calls the `chruby_reset()` method provided by chruby. Removing all custom
# environment variables, returning the ruby version to the system default.
#
function chruby_reset
  set -l IFS ";"
  bchruby 'chruby_reset; echo "$PATH;${GEM_PATH:-_}"' | \
    read -l ch_path ch_gem_path

  if test (id -u) != '0'
    set -e GEM_HOME

    if test "$ch_gem_path" = '_'
      set -e GEM_PATH
    else
      set -gx GEM_PATH "$ch_gem_path"
    end
  end

  set -gx PATH (echo $ch_path | tr : '\n')

  set -l unset_vars RUBY_ROOT RUBY_ENGINE RUBY_VERSION RUBYOPT GEM_ROOT
  for i in (seq (count $unset_vars))
    set -q $unset_vars[$i]; and set -e $unset_vars[$i]; or true
  end
end

#
# Set environment variables to point to custom Ruby install.
#
# Resets current Ruby version then runs chruby in bash, capturing it's defined
# variables and setting them in the current Fish instance.
#
function chruby_use
  set -l args '; echo "$RUBY_ROOT;${RUBYOPT:-_};${GEM_HOME:-_};${GEM_PATH:-_};${GEM_ROOT:-_};$PATH;$RUBY_ENGINE;$RUBY_VERSION;$?"'

  set -l IFS ";"
  bchruby 'chruby_use' $argv $args | read -l ch_ruby_root ch_rubyopt ch_gem_home \
                                         ch_gem_path ch_gem_root ch_path \
                                         ch_ruby_engine ch_ruby_version \
                                         ch_status

  test "$ch_status" = 0; or return 1
  test -n "$RUBY_ROOT"; and chruby_reset

  set -gx RUBY_ENGINE "$ch_ruby_engine"
  set -gx RUBY_VERSION "$ch_ruby_version"

  set -gx RUBY_ROOT $ch_ruby_root
  test "$ch_gem_root" = '_'; or set -gx GEM_ROOT "$ch_gem_root"
  test "$ch_rubyopt" = '_'; or set -gx RUBYOPT "$ch_rubyopt"

  # Fish warns the user when a path in the PATH environment variable does not
  # exist:
  #
  #   set: Warning: path component /path/to/bin may not be valid in PATH.
  #   set: No such file or directory
  #
  # Given that this happens for every Ruby install (until gems are installed in
  # these paths), we pre-create this directory, to silence Fish' warning.
  #
  for gem_path in (echo "$ch_gem_path" | tr : '\n')
    test -d "$gem_path/bin"; or mkdir -p "$gem_path/bin"
  end

  set -gx PATH (echo "$ch_path" | tr : '\n')

  if test (id -u) != '0'
    set -gx GEM_HOME "$ch_gem_home"
    set -gx GEM_PATH "$ch_gem_path"
  end
end

#
# Custom `chruby` command to be called in the Fish environment.
#
# Thin wrapper around the bash version of `chruby`, passing along arguments to
# it, and capturing the outputted environment variables to be set in Fish.
#
function chruby
  switch "$argv[1]"
    case '-h' '--help'
      bchruby "chruby $argv"
    case '-V' '--version'
      bchruby "chruby $argv"
      echo "chruby-fish: $CHRUBY_FISH_VERSION"
    case 'system'
      chruby_reset
    case '*'
      if test "$argv[1]" = ''
        bchruby "chruby $argv"
      else
        set -l dir ruby match
        for dir in $RUBIES
          set dir (echo "$dir" | sed -e 's|/$||')
          set ruby (echo "$dir" | awk -F/ '{print $NF}')

          test "$argv[1]" = "$ruby"; and set match "$dir"; and break
          echo "$ruby" | grep -q -- "$argv[1]"; and set match "$dir"
        end

        if test -z "$match"
          echo "chruby: unknown Ruby: $argv[1]" >&2
          return 1
        end

        set -e argv[1]
        chruby_use "$match" "$argv"
      end
  end
end
