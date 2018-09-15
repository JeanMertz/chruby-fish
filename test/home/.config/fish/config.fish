set -gx original_path $PATH
set -gx PATH $PATH /usr/local/bin /usr/bin /usr/sbin /bin /sbin "$PWD/test/home/path with spaces"

. $PWD/test/helper.fish
