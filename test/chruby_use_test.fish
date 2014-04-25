function suite_chruby_use
  function setup
    chruby_use '2.1.0'
  end

  function test_chruby_use
    assert_equal "$test_ruby_root" "$RUBY_ROOT"
    assert_equal "$test_ruby_engine" "$RUBY_ENGINE"
    assert_equal "$test_ruby_version" "$RUBY_VERSION"
    assert_equal "$test_ruby_root/lib/ruby/gems/$test_ruby_api" "$GEM_ROOT"
    assert_equal "$test_ruby_root/bin/ruby" (which ruby)
    assert_equal "$test_gem_home" "$GEM_HOME"
    assert_equal "$GEM_HOME:$GEM_ROOT" "$GEM_PATH"
    assert_equal "$test_gem_home/bin $test_gem_root/bin $test_ruby_root/bin $test_path" "$PATH"
  end
end

if not set -q tank_running
  source (dirname (status -f))/helper.fish
  tank_run
  reset_system_defaults
end
