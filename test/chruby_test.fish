function suite_chruby
  function test_chruby_default_RUBIES
    assert_equal "$test_ruby_root" "$RUBIES"
  end

  function test_chruby_2_1
    chruby '2.1'
    assert_equal "$test_ruby_root" "$RUBY_ROOT"
  end

  function test_chruby_multiple_matches
    set -g RUBIES /path/to/ruby-2.1.1 "$test_ruby_root"

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
  source (dirname (status -f))/helper.fish
  tank_run
  reset_system_defaults
end
