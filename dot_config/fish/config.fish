if status is-interactive
    set -gx ZK_NOTEBOOK_DIR "$HOME/mynotes"
    set -gx VISUAL neovide
    set -gx EDITOR nvim
    atuin init fish | source
    fish_vi_key_bindings
    # Commands to run in interactive sessions can go here
    source ~/.iterm2_shell_integration.fish
end

# Created by `pipx` on 2024-06-21 12:10:51
set PATH $PATH /home/khadd/.local/bin
