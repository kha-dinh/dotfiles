return {
  {
    "michaelb/sniprun",
    build = "sh install.sh",
    config = function()
      vim.api.nvim_set_keymap("v", "<leader>R", "<Plug>SnipRun", { silent = true })
      vim.api.nvim_set_keymap("n", "<leader>R", "<Plug>SnipRun", { silent = true })
      vim.api.nvim_set_keymap("n", "<leader>F", "<Plug>SnipRunOperator", { silent = true })
    end,
  },
}
