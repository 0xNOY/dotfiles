if status is-interactive
    # Commands to run in interactive sessions can go here

    set -g theme_newline_cursor yes
    set -g theme_newline_prompt " 󰘍 "
    set -g theme_show_exit_status yes
    set -g theme_display_jobs_verbose yes
    set -g fish_prompt_pwd_dir_length 1
end

eval "$(pyenv init -)"

set -x SHELL "/usr/bin/fish" 
set -x EDITOR "/usr/bin/nvim"

alias ls=lsd

alias vi=nvim
alias vim=nvim

alias rm=/usr/bin/rip
alias rm!=/usr/bin/rm

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/noy/.ghcup/bin $PATH # ghcup-env