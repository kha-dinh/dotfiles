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
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { max_lines = 0, separator = "─" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      textobjects = {
        swap = {
          enable = true,
          swap_next = {
            ["<leader>an"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>ap"] = "@parameter.inner",
          },
        },
      },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup({
        -- prompt for return type
        prompt_func_return_type = {
          go = true,
          cpp = true,
          c = true,
          java = true,
        },
        -- prompt for function parameters
        prompt_func_param_type = {
          go = true,
          cpp = true,
          c = true,
          java = true,
        },
      })
    end,
    keys = {
      {
        "<leader>re",
        function()
          require("refactoring").refactor("Extract Function")
        end,
        desc = "Extract selection into a function",
        mode = { "x" },
      },

      {
        "<leader>ri",
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        desc = "Extract selection into a function",
        mode = { "n", "x" },
      },

      {
        "<leader>rr",
        function()
          require("refactoring").select_refactor()
        end,
        desc = "Select refactor",
        mode = { "n", "x" },
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
