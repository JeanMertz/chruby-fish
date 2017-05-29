source ./test/helper.fish

function setup
  source ./test/helper.fish

  chruby_use $test_ruby_root >/dev/null
  set -x PATH $GEM_HOME/bin $GEM_ROOT/bin $RUBY_ROOT/bin $test_path

  chruby_reset
end

function teardown
  chruby_reset
end

test "$TESTNAME: chruby_reset hash table"
 -z (hash)
end

test "$TESTNAME: chruby_reset environment variable RUBY_ROOT"
  -z "$RUBY_ROOT"
end

test "$TESTNAME: chruby_reset environment variable RUBY_ENGINE"
  -z "$RUBY_ENGINE"
end

test "$TESTNAME: chruby_reset environment variable RUBY_VERSION"
  -z "$RUBY_VERSION"
end

test "$TESTNAME: chruby_reset environment variable RUBYOPT"
  -z "$RUBYOPT"
end

test "$TESTNAME: chruby_reset environment variable GEM_HOME"
  -z "$GEM_HOME"
end

test "$TESTNAME: chruby_reset environment variable GEM_PATH"
  -z "$GEM_PATH"
end

test "$TESTNAME: chruby_reset environment variable RUBY_ROOT"
  "$test_path" = "$PATH"
end
