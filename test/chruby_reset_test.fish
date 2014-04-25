function suite_chruby_reset
  function setup
    chruby_use '2.1.0'
    set -g PATH "$RUBY_ROOT/bin" $test_path
  end

  function test_chruby_reset
    chruby_reset

    assert_empty "$RUBY_ROOT"
    assert_empty "$RUBY_ENGINE"
    assert_empty "$RUBY_VERSION"
    assert_empty "$RUBYOPT"
    assert_empty "$GEM_HOME"
    assert_empty "$GEM_PATH"
  end

  function test_chruby_reset_duplicate_path
    set -gx PATH $PATH "$RUBY_ROOT/bin"

    chruby_reset
    assert_equal "$test_path" "$PATH"
  end

  function test_chruby_reset_modified_gem_path
    set -l gem_dir "$HOME/gems"
    set -gx GEM_PATH $GEM_PATH $gem_dir

    chruby_reset
    assert_equal "$gem_dir" "$GEM_PATH"
  end

  function test_chruby_reset_no_gem_root_or_gem_home
    set -e GEM_HOME
    set -e GEM_ROOT
    set -gx PATH $test_path /bin

    chruby_reset
    assert_equal "$test_path /bin" $PATH
  end
end

if not set -q tank_running
  source (dirname (status -f))/helper.fish
  tank_run
  reset_system_defaults
end
