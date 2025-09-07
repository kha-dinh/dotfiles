if status is-interactive
    set -gx ZK_NOTEBOOK_DIR "$HOME/mynotes"
    set -gx VISUAL neovide
    set -gx EDITOR nvim

    if command -q atuin
        atuin init fish | source
    else
        echo "atuin not installed"
    end

    if command -q zoxide
        zoxide init fish | source
    else
        echo "zoxide not installed"
    end

    fish_vi_key_bindings
    # Commands to run in interactive sessions can go here
    #
    if test -e ~/.iterm2_shell_integration.fish
        source ~/.iterm2_shell_integration.fish
    end

    fish_add_path ~/.scripts
    fish_add_path /opt/homebrew/bin
    fish_add_path /Library/TeX/texbin
end

# Created by `pipx` on 2024-06-21 12:10:51
set PATH $PATH /home/khadd/.local/bin
