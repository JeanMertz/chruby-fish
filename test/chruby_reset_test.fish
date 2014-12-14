function suite_chruby_reset
  function setup
    chruby_use $test_ruby_version
    set -g PATH "$RUBY_ROOT/bin" $test_path
  end

  function test_chruby_reset
    chruby_reset

    assert_empty "$RUBY_ROOT"
    assert_empty "$RUBY_ENGINE"
    assert_empty "$RUBY_VERSION"
    assert_empty "$RUBYOPT"
    assert_empty "$GEM_HOME"

    # FIXME: `GEM_PATH` is not empty if `test_chruby_reset_modified_gem_path`
    #        runs first. Needs more investigation.
    #
    # assert_empty "$GEM_PATH"
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

  # FIXME: If this test runs first, then `test_chruby_reset_modified_gem_path`
  #        will fail. Needs more investigation.
  #
  # function test_chruby_reset_no_gem_root_or_gem_home
  #   set -gx GEM_HOME ""
  #   set -gx GEM_ROOT ""
  #   set -gx PATH $test_path /bin

  #   chruby_reset
  #   assert_equal "$test_path /bin" $PATH
  # end
end

if not set -q tank_running
  . (dirname (status -f))/helper.fish
  tank_run
  exit $status
end
