. ./test/fish/helper.fish

function setup_tank
	chruby_use "$TEST_RUBY_ROOT" >/dev/null
	set PATH $TEST_PATH
	test -d $GEM_HOME/bin; and set PATH $GEM_HOME/bin $PATH
	test -d $GEM_ROOT/bin; and set PATH $GEM_ROOT/bin $PATH
	test -d $RUBY_ROOT/bin; and set PATH $RUBY_ROOT/bin $PATH
end

function it_sanitizes_ruby_root -d 'sanitizes RUBY_ROOT'
	chruby_reset
  test "$RUBY_ROOT" = ""
end

function it_sanitizes_ruby_engine -d 'sanitizes RUBY_ENGINE'
	chruby_reset
  test "$RUBY_ENGINE" = ""
end

function it_sanitizes_ruby_version -d 'sanitizes RUBY_VERSION'
	chruby_reset
  test "$RUBY_VERSION" = ""
end

function it_sanitizes_rubyopt -d 'sanitizes RUBYOPT'
	chruby_reset
  test "$RUBYOPT" = ""
end

function it_sanitizes_gem_home -d 'sanitizes GEM_HOME'
	chruby_reset
  test "$GEM_HOME" = ""
end

function it_sanitizes_gem_path -d 'sanitizes GEM_PATH'
	chruby_reset
  test "$GEM_PATH" = ""
end


function it_sanitizes_path -d 'sanitizes PATH'
  chruby_reset
  test "$TEST_PATH" = "$PATH"
end

function it_removes_duplicate_ruby_paths
	set PATH $TEST_PATH
	test -d $GEM_HOME/bin; and set PATH $GEM_HOME/bin $PATH
	test -d $GEM_ROOT/bin; and set PATH $GEM_ROOT/bin $PATH
	test -d $RUBY_ROOT/bin; and set PATH $RUBY_ROOT/bin $PATH

	chruby_reset

	test "$TEST_PATH" = "$PATH"
end

function it_resets_modified_gem_path
	set -xg GEM_PATH $GEM_PATH $HOME/gems
	chruby_reset

	test "$HOME/gems" = "$GEM_PATH"
	set -e GEM_PATH
end

function it_resets_no_gem_root_or_gem_home
	set -xg GEM_HOME ''
	set -xg GEM_ROOT ''
	set -xg PATH $TEST_PATH /bin

	chruby_reset

	test "$TEST_PATH /bin" = "$PATH"
end

. $fish_tank
