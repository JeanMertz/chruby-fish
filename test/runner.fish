function log
  echo -e "\x1b[1m\x1b[32m>>>\x1b[0m \x1b[1m\x1b[37m{$argv}\x1b[0m"
end

log "Running tests under $SHELL in interactive-mode ..."
set error 0

echo $argv | read -l test_path opts

for test in (dirname (status -f))/fish/*_test.fish
  log "Running $test ..."
  command fish -i $test $opts; or set error 1
  echo
end

log "Running tests under $SHELL in non-interactive-mode ..."

for test in (dirname (status -f))/fish/*_test.fish
  log "Running $test ..."
  command fish $test $opts; or set error 1
  echo
end
