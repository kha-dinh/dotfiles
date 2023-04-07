return {
  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local opts = {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }
      require("crates").setup(opts)
    end,
  },
}
