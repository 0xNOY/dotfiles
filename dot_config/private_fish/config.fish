if status is-interactive
    set -g theme_newline_cursor yes
    set -g theme_newline_prompt " 󰘍 "
    set -g theme_show_exit_status yes
    set -g theme_display_jobs_verbose yes
    set -g fish_prompt_pwd_dir_length 1

    command -q gtrash; and abbr --add rm "gtrash put"
    command -q fzf; and fzf --fish | source
end

set -gx SHELL /usr/bin/fish
set -gx EDITOR /usr/bin/nvim

command -q lsd; and alias ls=lsd
command -q nvim; and alias vi=nvim vim=nvim
