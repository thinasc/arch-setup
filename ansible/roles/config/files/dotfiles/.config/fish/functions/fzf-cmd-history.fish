function fzf-cmd-history --description "Show Command History"
  test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
  begin
    set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT $FZF_DEFAULT_OPTS --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS +m"
    history -z | eval (__fzfcmd) --read0 --print0 -q '(commandline)' | read -lz result
    and commandline -- $result
  end
  commandline -f repaint
end

function __fzfcmd
  test -n "$FZF_TMUX"; or set FZF_TMUX 0
  test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
  if [ -n "$FZF_TMUX_OPTS" ]
    echo "fzf-tmux $FZF_TMUX_OPTS -- "
  else if [ $FZF_TMUX -eq 1 ]
    echo "fzf-tmux -d$FZF_TMUX_HEIGHT -- "
  else
    echo "fzf"
  end
end
