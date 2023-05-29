return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ignore_install = { "help" }
    -- opts.highlight.additional_vim_regex_highlighting = {"markdown"}
  end,
}
