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
  -- {
  --   "folke/twilight.nvim",
  --   config = function()
  --     require("twilight").setup({
  --       context = 3,
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     })
  --   end,
  -- },
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
  -- {
  --   "brymer-meneses/grammar-guard.nvim",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --   },
  --   config = function()
  --     require("grammar-guard").init()
  --     require("lspconfig").grammar_guard.setup({
  --       cmd = { "ltex-ls" },
  --       settings = {
  --         ltex = {
  --           enabled = { "latex", "tex", "bib", "markdown" },
  --           language = "en",
  --           diagnosticSeverity = "information",
  --           sentenceCacheSize = 4000,
  --           completionEnabled = true,
  --           additionalRules = {
  --             enablePickyRules = false,
  --             motherTongue = "en",
  --           },
  --           checkFrequency = "save",
  --           dictionary = {},
  --           disabledRules = {},
  --           hiddenFalsePositives = {},
  --         },
  --       },
  --     })
  --   end,
  -- },
}
