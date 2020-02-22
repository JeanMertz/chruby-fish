function chruby_use -a root options
    if not test -x $root/bin/ruby
        echo "chruby: $root/bin/ruby not executable" >&2
        return 1
    end

    chruby_reset

    set -gx RUBY_ROOT $root
    set -gx RUBYOPT $options
    set -gx PATH $root/bin $PATH

    # Perform caching of ruby environment variables
    if not source $RUBY_ROOT/.chruby-env.fish 2>/dev/null
      $root/bin/ruby -e 'print "set -gx RUBY_ENGINE #{defined?(RUBY_ENGINE) ? RUBY_ENGINE : "ruby"};set -gx RUBY_VERSION #{RUBY_VERSION}";begin; require "rubygems"; print ";set -gx GEM_ROOT #{Gem.default_dir.inspect}"; rescue LoadError;end' 2>/dev/null | tee $RUBY_ROOT/.chruby-env.fish 2>/dev/null | source
    end

    if test $USER != "root"
        set -gx GEM_HOME "$HOME/.gem/$RUBY_ENGINE/$RUBY_VERSION"
        if test -n "$GEM_ROOT"
            set -gx GEM_PATH $GEM_ROOT $GEM_PATH
            set -gx PATH "$GEM_ROOT/bin" $PATH
        end
        set -gx GEM_PATH $GEM_HOME $GEM_PATH
        set -gx PATH "$GEM_HOME/bin" $PATH
    end
end
