source ./test/helper.fish

function setup
    source ./test/helper.fish
    source ./share/fish/vendor_conf.d/chruby_auto.fish

    chruby_reset
    set -q RUBY_AUTO_VERSION; and set -e RUBY_AUTO_VERSION; or true
end

function teardown
    functions --erase chruby_auto
    echo "2.1" >$test_project_dir/modified_version/.ruby-version
    cd "$PROJECT"
end

@test "chruby_auto loaded in Fish" "0" = (functions chruby_auto | grep -q 'on-event fish_prompt'; echo "$status")

@test "chruby_auto enter project dir" "$test_ruby_root" = (cd "$test_project_dir"; and chruby_auto; echo "$RUBY_ROOT")

@test "chruby_auto enter subdir directly" "$test_ruby_root" = (cd "$test_project_dir/sub_dir"; and chruby_auto; echo "$RUBY_ROOT")

@test "chruby_auto enter subdir" "$test_ruby_root" = (cd "$test_project_dir"; and chruby_auto; \
                       cd sub_dir; and chruby_auto; echo "$RUBY_ROOT")

@test "chruby_auto modified .ruby-version" "$test_ruby_root" = (cd "$test_project_dir/modified_version"; and chruby_auto; \
                       echo "2.2" > .ruby-version; and chruby_auto; echo "$RUBY_ROOT")

@test "chruby_auto overriding .ruby-version" -z (cd "$test_project_dir"; and chruby_auto; \
      chruby system; and chruby_auto; echo "$RUBY_ROOT")

@test "chruby_auto leave project dir" -z (cd "$test_project_dir"; and chruby_auto; \
      cd "$test_project_dir/.."; and chruby_auto; echo "$RUBY_ROOT")

@test "chruby_auto invalid .ruby-version keeps current Ruby version" "$test_ruby_root" = (cd "$test_project_dir"; and chruby_auto; \
                       cd "bad/"; and chruby_auto 2>/dev/null; echo "$RUBY_ROOT")

@test "chruby_auto invalid .ruby-version does not set RUBY_AUTO_VERSION" (cat "$test_project_dir/bad/.ruby-version") = (cd "$test_project_dir";
   and chruby_auto; cd "bad/"; and chruby_auto 2>/dev/null; echo "$RUBY_AUTO_VERSION")
