return {
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      -- Increase the animation speed
      local animate = require("mini.animate")
      opts.resize.timing = animate.gen_timing.linear({ duration = 50, unit = "total" })
      opts.scroll.timing = animate.gen_timing.linear({ duration = 50, unit = "total" })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.nvim" },
    opts = function(_, opts)
      -- local function lspstatus(_, msg, info)
      --   -- local active_clients = vim.lsp.get_client_by_id(info.client_id).name
      --   local active_clients = info
      --   -- for c in vim.lsp.get_active_clients() do
      --   --   print(c.config.name)
      --   --   active_clients = c.config.name .. "test"
      --   -- end
      --   return active_clients
      -- end
      table.insert(opts.sections.lualine_x, { "filetype" })
      table.insert(opts.sections.lualine_c, { require("auto-session.lib").current_session_name })

      -- table.insert(opts.sections.lualine_x, { lspstatus })
    end,
  },
  -- {
  --   "m4xshen/smartcolumn.nvim",
  --   opts = {},
  -- },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      local colors = require("catppuccin.palettes.mocha")
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = "#FC56B1", guifg = colors.base },
            InclineNormalNC = { guifg = "#FC56B1", guibg = colors.base },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
      })
    end,
  },
  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = false },
    },
    keys = { { "<leader>Z", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
    config = function()
      vim.o.winwidth = 5
      vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = false, duration = 50 },
      })
    end,
  },

  -- scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = function()
      local scrollbar = require("scrollbar")
      local colors = require("catppuccin.palettes.mocha")
      scrollbar.setup({
        handle = { color = colors.overlay0 },
        excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
        marks = {
          Search = { color = colors.blue },
          Error = { color = colors.red },
          Warn = { color = colors.yellow },
          Info = { color = colors.sky },
          Hint = { color = colors.teal },
          Misc = { color = colors.mauve },
        },
      })
    end,
  },
}
