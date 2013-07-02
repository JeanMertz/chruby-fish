set -e RUBY_AUTO_VERSION

function chruby_auto --on-event fish_prompt
  set -l org (pwd)
  set -l dir (pwd)
  set -l found ''
  set -l rversion ''

  while not test "$dir" = '/'
    set version_file "$dir/.ruby-version"

    if test -f "$version_file"
      set rversion (cat "$version_file")

      if test "$rversion" = "$RUBY_AUTO_VERSION"
        set found 'true'
        break
      else
        set found 'true'
        chruby "$rversion"; or return 1

        set -gx RUBY_AUTO_VERSION "$rversion"
        break
      end
    end

    cd $dir/..
    set dir (pwd)
  end
  cd $org

  if test -z "$found"; and test -n "$RUBY_AUTO_VERSION"
    chruby_reset
    set -e RUBY_AUTO_VERSION
  end
end
