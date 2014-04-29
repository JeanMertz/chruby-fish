set -gx PREFIX "$PWD/test"
set -g original_path $PATH
set -g original_rubies $RUBIES

set -l fish_tank /usr/local/share/fish-tank/tank.fish
if not test -e $fish_tank
  echo 'error: fish-tank is required to run these tests (https://github.com/terlar/fish-tank)'
  exit 1
end

. $fish_tank
. (dirname (status -f))/../share/chruby/chruby.fish
chruby_reset

set -g test_ruby_engine 'ruby'
set -g test_ruby_version (test (uname) = 'Darwin'; and echo '2.1.1'; or echo '2.1.0')
set -g test_ruby_api '2.1.0'
set -g test_ruby_root "$PWD/test/opt/rubies/$test_ruby_engine-$test_ruby_version"

set -g test_path $PATH
set -g test_gem_home "$HOME/.gem/$test_ruby_engine/$test_ruby_version"
set -g test_gem_root "$test_ruby_root/lib/ruby/gems/$test_ruby_api"

set -g test_project_dir "$PWD/test/project"

function teardown
  chruby_reset
end

# reset to original state after finishing tests
function reset_system_defaults
  set -gx PATH $original_path
  set -e original_path
  set -q original_prefix; and set -gx PREFIX $original_prefix
end

function error_build -e test_failure
  set -Ux TEST_ERROR 1
end
