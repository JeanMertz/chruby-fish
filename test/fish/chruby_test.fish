. ./test/fish/helper.fish

function it_sets_ruby_1_9
  chruby '1.9' >/dev/null
  test "$TEST_RUBY_ROOT" = "$RUBY_ROOT"
end

function it_picks_the_last_of_multiple_matches
  set -xU RUBIES "/path/to/ruby-1.9.0" "$TEST_RUBY_ROOT"
  chruby '1.9' >/dev/null
  test "$TEST_RUBY_ROOT" = "$RUBY_ROOT"
end

function it_resets_to_system_ruby
  chruby "$TEST_RUBY_VERSION" >/dev/null
  chruby system
  test "$RUBY_ROOT" = ""
end

function it_returns_error_status_for_unknown_ruby
  chruby 'foo' 2>/dev/null
  test $status -eq 1
end

function it_returns_error_status_for_invalid_ruby
  set -xU RUBIES '/does/not/exist/jruby'
  chruby 'jruby' 2>/dev/null
  test $status -eq 1
end

function clean_tank
  set -eU RUBIES
  chruby_reset
end

. $fish_tank
