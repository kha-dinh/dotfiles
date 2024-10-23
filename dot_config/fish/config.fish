if status is-interactive
    set -gx ZK_NOTEBOOK_DIR "$HOME/mynotes"
    set -gx VISUAL neovide
    set -gx EDITOR nvim
    atuin init fish | source
    zoxide init fish | source
    fish_vi_key_bindings
    # Commands to run in interactive sessions can go here
    source ~/.iterm2_shell_integration.fish
    fish_add_path ~/.scripts
    fish_add_path /opt/homebrew/bin
    fish_add_path /Library/TeX/texbin
end

# Created by `pipx` on 2024-06-21 12:10:51
set PATH $PATH /home/khadd/.local/bin
