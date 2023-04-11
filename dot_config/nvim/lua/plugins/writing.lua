return {
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        context = 3,
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "rudism/telescope-dict.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "<leader>td",
        function()
          require("telescope").extensions.dict.synonyms()
        end,
        mode = "n",
        desc = "Find symnonyms",
      },
    },
  },
}
