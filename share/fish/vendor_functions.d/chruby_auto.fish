function chruby_auto -e fish_prompt
    set -l dir $PWD/
    while test -n "$dir"
        set dir (string replace -r '/[^/]*$' '' $dir)
        if test -f "$dir/.ruby-version"; and read -l ruby_version <"$dir/.ruby-version"
            if test $ruby_version = "$RUBY_AUTO_VERSION"
                return
            end
            set -g RUBY_AUTO_VERSION $ruby_version
            chruby $ruby_version
            return $status
        end
    end

    if test -n "$RUBY_AUTO_VERSION"
        chruby_reset
        set -e RUBY_AUTO_VERSION
    end
end
