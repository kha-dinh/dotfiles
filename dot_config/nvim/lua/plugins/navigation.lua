return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "ray-x/lsp_signature.nvim",
        opts = {},
        config = function(_, opts)
          require("lsp_signature").setup(opts)
        end,
      },
      {
        "ray-x/navigator.lua",
        dependencies = {
          { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
          { "neovim/nvim-lspconfig" },
        },
        config = function()
          require("navigator").setup({
            mason = true,
            lsp = { disable_lsp = { "ccls" }, format_on_save = false },
          })
        end,
      },
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     {
  --       "SmiteshP/nvim-navbuddy",
  --       dependencies = {
  --         "MunifTanjim/nui.nvim",
  --       },
  --       opts = { lsp = { auto_attach = true } },
  --     },
  --   },
  -- },
}
