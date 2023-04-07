return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup()
    end,

    keys = {
      { "<esc><esc>", "<c-\\><c-n>", mode = "t", desc = "Enter Normal Mode" },
      { "<C-t>", "<cmd>ToggleTerm<cr>", mode = "n" },
      { "<C-t>", "<cmd>ToggleTerm<cr>", mode = "t" },
    },
  },
}
