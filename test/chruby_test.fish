function suite_chruby
  function setup
    set original_rubies $RUBIES
  end

  function teardown
    chruby_reset
    set RUBIES $original_rubies
  end

  function test_chruby_default_RUBIES
    assert_equal "$test_ruby_root" "$RUBIES"
  end

  function test_chruby_version
    set chruby_fish_version (chruby --version)
    set chruby_fish_V (chruby -V)
    set expected_output "chruby: $CHRUBY_VERSION chruby-fish: $CHRUBY_FISH_VERSION"

    assert_equal "$expected_output" "$chruby_fish_version"
    assert_equal "$expected_output" "$chruby_fish_V"
  end

  function test_chruby_help
    set chruby_fish_help (chruby --help)
    set chruby_fish_h (chruby -h)
    set expected_output 'usage: chruby [RUBY|VERSION|system] [RUBYOPT...]'

    assert_equal "$expected_output" "$chruby_fish_help"
    assert_equal "$expected_output" "$chruby_fish_h"
  end

  function test_chruby_2_1
    chruby '2.1'
    assert_equal "$test_ruby_root" "$RUBY_ROOT"
  end

  function test_chruby_multiple_matches
    set -g RUBIES /path/to/ruby-2.1.0 "$test_ruby_root"

    chruby '2.1'
    assert_equal "$test_ruby_root" "$RUBY_ROOT"
  end

  function test_chruby_exact_match_first
    set -g RUBIES "$test_ruby_root" "$test_ruby_root-rc1"

    chruby "$test_ruby_engine-$test_ruby_version"
    assert_equal "$test_ruby_root" "$RUBY_ROOT"
  end

  function test_chruby_system
    chruby "$test_ruby_version"
    chruby 'system'

    assert_empty "$RUBY_ROOT"
  end

  function test_chruby_unknown
    chruby 'does_not_exist' 2>/dev/null
    refute $status
  end

  function test_chruby_invalid_ruby
    set -g RUBIES '/does/not/exist/jruby'

    chruby 'jruby' 2>/dev/null
    refute $status
  end
end

if not set -q tank_running
  . (dirname (status -f))/helper.fish
  tank_run
  exit $status
end
