set -gx RUBIES $HOME/.rubies/* $PREFIX/opt/rubies/*/
set -gx CHRUBY_VERSION '1.0.0'

function chruby_reset
	test -z $RUBY_ROOT; and return

	set -gx PATH (string match -v $RUBY_ROOT/bin $PATH)

  if test (id -u) != 0
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

function chruby_use -a root options
	if not test -x $root/bin/ruby
		echo "chruby: $root/bin/ruby not executable" >&2
		return 1
  end

  chruby_reset

  set -gx RUBY_ROOT $root
  set -gx RUBYOPT $options
  set -gx PATH $root/bin $PATH

  eval ($root/bin/ruby -e 'print "set -gx RUBY_ENGINE #{defined?(RUBY_ENGINE) ? RUBY_ENGINE : "ruby"};set -gx RUBY_VERSION #{RUBY_VERSION}";begin; require "rubygems"; print ";set -gx GEM_ROOT #{Gem.default_dir.inspect}"; rescue LoadError;end')
  if test (id -u) != 0
		set -gx GEM_HOME "$HOME/.gem/$RUBY_ENGINE/$RUBY_VERSION"
    if test -n "$GEM_ROOT"
      set -gx GEM_PATH $GEM_ROOT $GEM_PATH
      set -gx PATH "$GEM_ROOT/bin" $PATH
    end
    set -gx GEM_PATH $GEM_HOME $GEM_PATH
    set -gx PATH "$GEM_HOME/bin" $PATH
  end
end

function chruby -a ruby_version
  switch $ruby_version
    case '-h' '--help'
			echo "usage: chruby [RUBY|VERSION|system] [RUBYOPT...]"
    case '-V' '--version'
			echo "chruby: $CHRUBY_VERSION"
    case 'system'
      chruby_reset
    case ''
      for dir in $RUBIES
        if test "$RUBY_ROOT" = $dir
          echo -n ' * '
        else
          echo -n '   '
        end
        echo (string match -r '[^/]*$' $dir)
      end
    case '*'
      set -l match
      for dir in $RUBIES
        set -l ruby (basename $dir)
        if string match -q -e $ruby_version $ruby
          set match $dir
          if test $ruby_version = $ruby
            break
          end
        end
      end

      if test -z $match
        echo "chruby: unknown Ruby: $ruby_version" >&2
        return 1
      end

      set argv argv[1..]
      chruby_use $match "$argv"
  end
end
