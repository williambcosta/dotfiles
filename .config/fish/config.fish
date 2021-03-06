if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

# Bindings
function fish_user_key_bindings
    bind \cC kill-whole-line
    bind \cH backward-kill-word
    bind \cL kill-word
end

# "Alias" to help versionate the users dotfiles. It calls git passing $HOME/.dotfiles
# as the bare directory and $HOME as the working tree plus the arguments typed
function dfc
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
