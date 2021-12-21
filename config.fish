# This is a hack to prevent this file from being sourced twice
if not status is-interactive
    exit
end

for f in ~/.config/fish/functions/private/*
    source $f
end

# Binds option-up
bind \e\[1\;5A history-token-search-backward
# Binds super-up (for emacs vterm integration, where there is no "option"
bind \e\[1\;2A history-token-search-backward

# option-down
bind \e\[1\;5B history-token-search-forward
# super-down
bind \e\[1\;2B history-token-search-forward

# Make C-t transpose characters :)
bind \ct transpose-chars

# Make C-s accept autocompletion and submit :))
bind \cs end-of-line execute

test -e ~/.profile && source ~/.profile
test -e ~/.fish_abbrs.fish && source ~/.fish_abbrs.fish

function postexec_source_profile --on-event fish_postexec
    set command_line (echo $argv | string collect | string trim)

    if test "$command_line" = "$EDITOR ~/.profile"
        echo -n 'Sourcing .profile... '
        source ~/.profile
        echo done.
    end
end

type -q zoxide && zoxide init fish | source

# Emacs vterm integration causes an error in vim :terminal
if string-empty $VIM
    function fish_vterm_prompt_end --on-event fish_prompt
        printf '\e]51;A'(whoami)'@'(hostname)':'(pwd)'\e\\'
    end
end
