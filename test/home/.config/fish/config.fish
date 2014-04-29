set -gx original_path $PATH
set -gx PATH $PATH /usr/local/bin /usr/bin /usr/sbin /bin /sbin

. $PWD/test/helper.fish
