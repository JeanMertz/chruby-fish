export PREFIX="$PWD/test"
export HOME="$PREFIX/home"
export PATH="$PWD/bin:$PATH"

. /usr/local/share/chruby/chruby.sh
chruby_reset

test_ruby_engine="ruby"
test_ruby_version=$([[ $(uname) = 'Darwin' ]] && echo '2.1.1' || echo '2.1.0')
test_ruby_api="2.1.0"
test_ruby_root="$PWD/test/opt/rubies/$test_ruby_engine-$test_ruby_version"

test_path="$PATH"
test_gem_home="$HOME/.gem/$test_ruby_engine/$test_ruby_version"
test_gem_root="$test_ruby_root/lib/ruby/gems/$test_ruby_api"

test_project_dir="$PWD/test/project"
