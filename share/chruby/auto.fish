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

set -e RUBY_AUTO_VERSION

#
# Wrapper around bash `chruby_auto`.
#
# This wrapper triggers the bash version of `chruby_auto`, captures its output
# as `RUBY_ENGINE` and `RUBY_VERSION` and fires the Fish wrapper around the
# `chruby` tool, passing along the `$RUBY_ENGINE-$RUBY_VERSION` argument to the
# command.
#
# You can optionally set the $CHRUBY_ROOT environment variable if your
# `chruby.sh` and `auto.sh` are located in a custom path.
#
function chruby_auto -e fish_prompt
  set -q CHRUBY_ROOT; or set CHRUBY_ROOT /usr/local

  #
  # line 1: source official `chruby.sh` file.
  # line 2: unset BASH_VERSION so that sourcing `auto.sh` doesn't trigger an
  #         initial `chruby_auto` execution.
  # line 3: source official `auto.sh` file.
  # line 4: set `RUBY_AUTO_VERSION` to currently active RUBY_AUTO_VERSION. This
  #         is required because sourcing `auto.sh` unset this variable.
  # line 5: manually run `chruby_auto`, only switching rubies if
  #         `RUBY_AUTO_VERSION` doesn't match the string in `.ruby-version`.
  # line 6: echo `$RUBY_AUTO_VERSION` to capture in Fish shell.
  #
  command bash -c "source $CHRUBY_ROOT/share/chruby/chruby.sh; \
                   unset BASH_VERSION;                         \
                   source $CHRUBY_ROOT/share/chruby/auto.sh;   \
                   RUBY_AUTO_VERSION=$RUBY_AUTO_VERSION;       \
                   chruby_auto;                                \
                   echo \$RUBY_AUTO_VERSION" 2>/dev/null |     \
                   read -l ch_ruby_auto_version

  #
  # if non-equal, either `chruby` ran, or no .ruby-version was detected. If
  # equal, a .ruby-version was detected, but it equals active
  # RUBY_AUTO_VERSION, so we return quickly.
  #
  if test "$ch_ruby_auto_version" != "$RUBY_AUTO_VERSION"
    set -gx RUBY_AUTO_VERSION "$ch_ruby_auto_version"

    if test -n "$RUBY_AUTO_VERSION"
      chruby "$RUBY_AUTO_VERSION"
    else
      chruby_reset
    end
  else
    return
  end
end
