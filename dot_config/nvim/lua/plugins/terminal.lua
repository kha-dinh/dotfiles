return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {--[[ things you want to change go here]]
      direction = "tab",
    },

    keys = {
      { "<esc><esc>", "<c-\\><c-n>", mode = "t", desc = "Enter Normal Mode" },
      { "<C-t>", "<cmd>ToggleTerm<cr>", mode = "n" },
      { "<C-t>", "<cmd>ToggleTerm<cr>", mode = "t" },
    },
  },
}
