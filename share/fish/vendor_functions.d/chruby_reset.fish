function chruby_reset
    test -z $RUBY_ROOT; and return

    set -gx PATH (string match -v $RUBY_ROOT/bin $PATH)

    if test $USER != "root"
        set -gx PATH (string match -v $GEM_HOME/bin $PATH)
        set -gx GEM_PATH (string match -v $GEM_HOME $GEM_PATH)
        if test -n "$GEM_ROOT"
            set -gx PATH (string match -v "$GEM_ROOT/bin" $PATH)
            set -gx GEM_PATH (string match -v $GEM_ROOT $GEM_PATH)
        end

        if test -z "$GEM_PATH"
            set -eg GEM_PATH
        end
        set -eg GEM_HOME
        set -eg GEM_ROOT
    end

    set -eg RUBY_ROOT
    set -eg RUBY_ENGINE
    set -eg RUBY_VERSION
    set -eg RUBYOPT
end
