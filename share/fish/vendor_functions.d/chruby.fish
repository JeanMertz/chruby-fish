set -g CHRUBY_VERSION '1.0.0'

function chruby -a ruby_version
    if not set -q RUBIES_DIR
      set RUBIES_DIR $HOME/.rubies
    end

    set RUBIES $RUBIES_DIR/* $PREFIX/opt/rubies/*

    switch "$ruby_version"
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
                set -l ruby (string split -r -m1 / "$dir")[2]
                echo $ruby
            end
        case '*'
            set -l match
            for dir in $RUBIES
                set -l ruby (string split -r -m1 / "$dir")[2]
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

            set -e argv[1]
            chruby_use $match "$argv"
    end
end
