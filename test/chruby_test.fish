source ./test/helper.fish

function setup
  source ./test/helper.fish

  set original_rubies "$RUBIES"
end

function teardown
  chruby_reset
  set RUBIES $original_rubies
end

test "$TESTNAME: chruby default RUBIES"
  "$test_ruby_root" = "$RUBIES"
end

test "$TESTNAME: chruby 2.2"
  "$test_ruby_root" = (chruby "2.2"; echo "$RUBY_ROOT")
end

test "$TESTNAME: chruby multiple matches"
  "$test_ruby_root" = (set RUBIES "/path/to/ruby-2.2" "$test_ruby_root"; \
                       chruby "2.2"; echo "$RUBY_ROOT")
end

test "$TESTNAME: chruby exact match first"
  "$test_ruby_root" = (set RUBIES "$test_ruby_root" "$test_ruby_root-rc1"; \
                       chruby (echo "$test_ruby_root" | awk -F/ '{print $NF}'); \
                       echo "$RUBY_ROOT")
end

test "$TESTNAME: chruby system"
  -z (chruby "$test_ruby_version" >/dev/null; chruby system; echo "$RUBY_ROOT")
end

test "$TESTNAME: chruby unknown"
  "1" = (chruby "does_not_exist" 2>/dev/null; echo "$status")
end

test "$TESTNAME: chruby invalid ruby"
  "1" = (set RUBIES "/does/not/exist/jruby"; chruby "jruby" 2>/dev/null; echo "$status")
end

test "$TESTNAME: chruby unknown Ruby does_not_exist"
  "chruby: unknown Ruby: does_not_exist" = (chruby "does_not_exist" 2>&1)
end

test "$TESTNAME: chruby unknown Ruby -v"
  "chruby: unknown Ruby: -v" = (chruby "-v" 2>&1)
end

test "$TESTNAME: chruby supports .bash_profile"
  "$HOME" = (touch $HOME/tmp; chruby "2.2"; cat $HOME/tmp)
end

# FIXME: error on Travis for Fish 2.2.0
#
# test "$TESTNAME: chruby show active"
#   " * $test_ruby_engine-$test_ruby_version" = (chruby | head -n1)
# end
