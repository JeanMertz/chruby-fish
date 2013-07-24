set -e RUBY_AUTO_VERSION

function chruby_auto --on-event fish_prompt
  set -l org (pwd)
  set -l dir (pwd)
  set -l found ''
  set -l rversion ''
  set -l status_code 0

  while not test "$dir" = '/'
    set version_file "$dir/.ruby-version"

    if test -f "$version_file"
      set rversion (cat "$version_file")

      if test "$rversion" = "$RUBY_AUTO_VERSION"
        set found 'true'
        break
      else
        set found 'true'
        set -gx RUBY_AUTO_VERSION "$rversion"

        chruby "$rversion"; or set status_code 1
        break
      end
    end

    cd $dir/..
    set dir (pwd)
  end
  cd $org

  test $status_code = 1; and return 1

  if begin; test -z "$found"; and test -n "$RUBY_AUTO_VERSION"; end
    chruby_reset
    set -e RUBY_AUTO_VERSION
  end
end
