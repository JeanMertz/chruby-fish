. (dirname (status -f))/../share/chruby/auto.fish

function suite_chruby_auto
  function setup
    chruby_reset
    set -e RUBY_AUTO_VERSION
  end

  function test_chruby_auto_enter_project_dir
    cd "$test_project_dir"; and chruby_auto

    assert_equal "$test_ruby_root" "$RUBY_ROOT"
  end

  function test_chruby_auto_enter_subdir_directly
    cd "$test_project_dir/sub_dir"; and chruby_auto

    assert_equal "$test_ruby_root" "$RUBY_ROOT"
  end

  function test_chruby_auto_enter_subdir
    cd "$test_project_dir"; and chruby_auto
    cd sub_dir; and chruby_auto

    assert_equal "$test_ruby_root" "$RUBY_ROOT"
  end

  function test_chruby_auto_enter_subdir_with_ruby_version
    cd "$test_project_dir"; and chruby_auto
    cd sub_versioned/; and chruby_auto

    assert_empty "$RUBY_ROOT"
  end

  function test_chruby_auto_modified_ruby_version
    cd "$test_project_dir/modified_version"; and chruby_auto
    echo '2.1' > .ruby-version; and chruby_auto

    assert_equal "$test_ruby_root" "$RUBY_ROOT"
  end

  function test_chruby_auto_overriding_ruby_version
    cd "$test_project_dir"; and chruby_auto
    chruby system; and chruby_auto

    assert_empty "$RUBY_ROOT"
  end

  function test_chruby_auto_leave_project_dir
    cd "$test_project_dir"; and chruby_auto
    cd "$test_project_dir/.."; and chruby_auto

    assert_empty "$RUBY_ROOT"
  end

  function test_chruby_auto_invalid_ruby_version
    set -l expected_auto_version (cat $test_project_dir/bad/.ruby-version)

    cd "$test_project_dir"; and chruby_auto
    cd bad/; and chruby_auto 2>/dev/null

    assert_equal "$test_ruby_root" "$RUBY_ROOT"
    assert_equal "$expected_auto_version" "$RUBY_AUTO_VERSION"
  end
end

if not set -q tank_running
  . (dirname (status -f))/helper.fish
  tank_run
  reset_system_defaults
end
