# The MIT License (MIT)
#
# Copyright (c) 2014 Jean Mertz <jean@mertz.fm>
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

#
# Wrapper around bash `chruby_auto`.
#
# This wrapper triggers the bash version of `chruby_auto`, captures its output
# as `RUBY_ENGINE` and `RUBY_VERSION` and fires the Fish wrapper around the
# `chruby` tool, passing along the `$RUBY_ENGINE-$RUBY_VERSION` argument to the
# command.
#
# You can optionally set the $CHRUBY_SOURCE environment variable if your
# `chruby.sh` and `auto.sh` are located in a custom path.
#
function chruby_auto --on-variable PWD
  status --is-command-substitution; and return

  set -q CHRUBY_SOURCE; or set CHRUBY_SOURCE /usr/local/share/chruby/chruby.sh
  set -l source_dir (dirname "$CHRUBY_SOURCE")

  command bash -c "source $source_dir/chruby.sh; \
                   source $source_dir/auto.sh; \
                   echo \$RUBY_ENGINE \$RUBY_VERSION" | \
                   read -l ch_ruby_engine ch_ruby_version

  if test -n "$ch_ruby_engine"; and test -n "$ch_ruby_version"
    chruby "$ch_ruby_engine-$ch_ruby_version"
  end
end
