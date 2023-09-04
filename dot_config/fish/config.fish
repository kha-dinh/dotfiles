if status is-interactive

  set  -gx ZK_NOTEBOOK_DIR "$HOME/mynotes"
  atuin init fish | source
    # Commands to run in interactive sessions can go here
end
