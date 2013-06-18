. ./test/fish/helper.fish

function setup_tank
	set -gx TEST_PATH "$PATH"
	chruby_use $TEST_RUBY_ROOT >/dev/null
end

function it_sets_ruby_root -d 'sets RUBY_ROOT'
	test "$TEST_RUBY_ROOT" = "$RUBY_ROOT"
end

function it_sets_ruby_enine -d 'sets RUBY_ENGINE'
	test "$TEST_RUBY_ENGINE" = "$RUBY_ENGINE"
end

function it_sets_ruby_version -d 'sets RUBY_VERSION'
	test "$TEST_RUBY_VERSION" = "$RUBY_VERSION"
end

function it_sets_gem_root -d 'sets GEM_ROOT'
	test "$TEST_RUBY_ROOT/lib/ruby/gems/$TEST_RUBY_API" = "$GEM_ROOT"
end

function it_sets_gem_home -d 'sets GEM_HOME'
	test "$TEST_GEM_HOME" = "$GEM_HOME"
end

function it_sets_gem_path -d 'sets GEM_PATH'
	test "$GEM_HOME $GEM_ROOT" = "$GEM_PATH"
end

function it_sets_path -d 'sets PATH'
	test "$TEST_GEM_HOME/bin $TEST_GEM_ROOT/bin $TEST_RUBY_ROOT/bin $TEST_PATH" = "$PATH"
end

function it_finds_ruby_in_path
	test "$TEST_RUBY_ROOT/bin/ruby" = (which ruby)
end

function it_prints_ruby_version_in_interactive_mode
	builtin status -i; or return 0
	set -l output (chruby_use "$TEST_RUBY_ROOT")

	test "Using $TEST_RUBY_ENGINE-$TEST_RUBY_VERSION" = "$output"
end

function it_does_not_print_ruby_version_in_non_interactive_mode
	builtin status -i; and return 0
	set -l output (chruby_use "$TEST_RUBY_ROOT")

	test "$output" = ''
end

function clean_tank
  set -eU RUBIES
  chruby_reset
end

. $fish_tank
