set fish_tank /usr/local/share/fish-tank/tank.fish
if not test -e $fish_tank
  set -e fish_tank
  echo 'error: fish-tank is required to run these tests (https://github.com/terlar/fish-tank)'
  exit 1
end

. ./share/chruby/chruby.fish
set PATH $PWD/bin $PATH

chruby_reset

set -gx TEST_PATH $PATH
set -gx TEST_RUBY_ENGINE 'ruby'
set -gx TEST_RUBY_VERSION '1.9.3'
set -gx TEST_RUBY_PATCHLEVEL '392'
set -gx TEST_RUBY_API '1.9.1'
set -gx TEST_RUBY_ROOT "/opt/rubies/ruby-$TEST_RUBY_VERSION-p$TEST_RUBY_PATCHLEVEL"

if not test -d $TEST_RUBY_ROOT
  echo "error: $TEST_RUBY_ENGINE $TEST_RUBY_VERSION-p$TEST_RUBY_PATCHLEVEL is\
 required to be installed in $TEST_RUBY_ROOT for these test to function correctly."
  exit 1
end

set -gx TEST_GEM_HOME "$HOME/.gem/$TEST_RUBY_ENGINE/$TEST_RUBY_VERSION"
set -gx TEST_GEM_ROOT "$TEST_RUBY_ROOT/lib/ruby/gems/$TEST_RUBY_API"

set -gx RUBIES $TEST_RUBY_ROOT

function setup_tank; return; end
function clean_tank; return; end
