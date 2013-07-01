set -e RUBY_VERSION_FILE

function chruby_auto --on-event fish_prompt
  set -l org (pwd)
  set -l dir (pwd)
  set -l found ''

  while not test "$dir" = '/'
    set version_file "$dir/.ruby-version"

    if test "$version_file" = "$RUBY_VERSION_FILE"
      set found 'true'
      break
    else if test -f "$version_file"
      set found 'true'
      chruby (cat "$version_file")
      set -gx RUBY_VERSION_FILE "$version_file"
      break
    end

    cd $dir/..
    set dir (pwd)
  end
  cd $org

  if test -z "$found"; and test -n "$RUBY_VERSION_FILE"
    chruby_reset
    set -e RUBY_VERSION_FILE
  end
end
