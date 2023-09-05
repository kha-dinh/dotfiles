if status is-interactive

  set  -gx ZK_NOTEBOOK_DIR "$HOME/mynotes"
  atuin init fish | source
  fish_vi_key_bindings
    # Commands to run in interactive sessions can go here
end
