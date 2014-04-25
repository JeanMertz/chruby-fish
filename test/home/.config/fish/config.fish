set -gx original_path $PATH
set -gx PATH $PATH /usr/local/bin /usr/bin /usr/sbin /bin /sbin

source $PWD/test/helper.fish
