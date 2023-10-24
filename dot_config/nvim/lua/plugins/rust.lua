return {
  {
    "saecki/crates.nvim",
    config = function()
      local opts = {}
      require("crates").setup(opts)
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "saecki/crates.nvim" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "crates" } }))
    end,
  },
}
