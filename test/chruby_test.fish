source ./test/helper.fish

function setup
    source ./test/helper.fish
    source ./share/fish/vendor_functions.d/chruby.fish

    set original_rubies "$RUBIES"
end

function teardown
    chruby_reset
    set RUBIES $original_rubies
end

@test "chruby default RUBIES" "$test_ruby_root" = "$RUBIES"

@test "chruby 2.2" "$test_ruby_root" = (chruby "2.2"; echo "$RUBY_ROOT")

@test "chruby multiple matches" "$test_ruby_root" = (set RUBIES "/path/to/ruby-2.2" "$test_ruby_root"; \
                       chruby "2.2"; echo "$RUBY_ROOT")

@test "chruby exact match first" "$test_ruby_root" = (set RUBIES "$test_ruby_root" "$test_ruby_root-rc1"; \
                       chruby (echo "$test_ruby_root" | awk -F/ '{print $NF}'); \
                       echo "$RUBY_ROOT")

@test "chruby system" -z (chruby "$test_ruby_version" >/dev/null; chruby system; echo "$RUBY_ROOT")

@test "chruby unknown" "1" = (chruby "does_not_exist" 2>/dev/null; echo "$status")

@test "chruby invalid ruby" "1" = (set RUBIES "/does/not/exist/jruby"; chruby "jruby" 2>/dev/null; echo "$status")

@test "chruby unknown Ruby does_not_exist" "chruby: unknown Ruby: does_not_exist" = (chruby "does_not_exist" 2>&1)

@test "chruby unknown Ruby -v" "chruby: unknown Ruby: -v" = (chruby "-v" 2>&1)

@test "chruby show active" " * $test_ruby_engine-$test_ruby_version" = (chruby "2.2"; chruby)
