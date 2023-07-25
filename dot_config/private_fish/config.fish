if status is-interactive
    # Commands to run in interactive sessions can go here

    set -g theme_newline_cursor yes
    set -g theme_newline_prompt " 󰘍 "
end

eval "$(pyenv init -)"

set -x SHELL "/usr/bin/fish" 
set -x EDITOR "/usr/bin/nvim"

alias ls=lsd

alias vi=nvim
alias vim=nvim

alias rm=/usr/bin/rip
alias rm!=/usr/bin/rm
