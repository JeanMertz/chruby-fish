export PREFIX="$PWD/test"
export HOME="$PREFIX/home"
export PATH="$PWD/bin:$PATH"

test_ruby_engine="ruby"
test_ruby_version="2.2.5"
test_ruby_api="2.2.0"
test_ruby_root="$PWD/test/opt/rubies/$test_ruby_engine-$test_ruby_version"

test_path="$PATH"
test_gem_home="$HOME/.gem/$test_ruby_engine/$test_ruby_version"
test_gem_root="$test_ruby_root/lib/ruby/gems/$test_ruby_api"

test_project_dir="$PWD/test/project"
