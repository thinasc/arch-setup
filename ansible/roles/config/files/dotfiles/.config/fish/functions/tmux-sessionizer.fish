function tmux-sessionizer --description "TMUX Sessionizer"
  if test ! -z "$argv"
    set selected $argv[1]
  else
    set selected (find $HOME/projects -mindepth 1 -maxdepth 1 -type d | fzf)
  end
  
  if test -z "$selected"
    return
  end

  set selected_name (basename "$selected" | tr . _)

  tmux new-session -s $selected_name -c $selected

end
