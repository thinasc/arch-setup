set fish_greeting

# Hooks
direnv hook fish | source
starship init fish | source
zoxide init fish | source

# Theme
set -gx TERM xterm-256color

# General
set -gx EDITOR nvim
set -gx GIT_EDITOR $EDITOR
set -gx PROJECTS $HOME/projects
set -gx TMUXINATOR_CONFIG $HOME/.config/tmuxinator
set -gx STARSHIP_CONFIG $HOME/.config/starship/starship.toml
set -gx LG_CONFIG_FILE $HOME/.config/lazygit/config.yml

# Hyprland
set -gx WLR_EGL_NO_MODIFIERS 1
set -gx XDG_CURRENT_DESKTOP Hyprland
set -gx XDG_SESSION_TYPE wayland
set -gx XDG_SESSION_DESKTOP Hyprland

# Alias
source (dirname (status --current-filename))/alias.fish

# Bind
source (dirname (status --current-filename))/binds.fish
