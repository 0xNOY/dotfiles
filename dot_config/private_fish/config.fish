if status is-interactive
    # Commands to run in interactive sessions can go here
end

eval "$(pyenv init -)"

set -x SHELL "/usr/bin/fish" 

alias ls=lsd

alias vi=nvim
alias vim=nvim

alias rm=/usr/bin/rip
alias rm!=/usr/bin/rm
