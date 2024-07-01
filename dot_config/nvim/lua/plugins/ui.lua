return {
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

      -- table.insert(opts.sections.lualine_x, { lspstatus })
    end,
  },
  -- {
  --   "m4xshen/smartcolumn.nvim",
  --   opts = {},
  -- },
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup({
        hint = "floating-big-letter",
        filter_rules = {
          bo = {
            filetype = { "incline", "notify", "noice", "scrollbar", "NvimSeparator" },
            buftype = { "special", "terminal" },
          },
        },
      })
    end,
    keys = {
      {
        "<leader>wp",
        function()
          local window_id = require("window-picker").pick_window()
          if window_id then
            -- local option = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(window_id), "filetype")
            -- print(option)
            vim.api.nvim_set_current_win(window_id)
          end
        end,
        "Select window",
      },
    },
  },
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    -- config = function()
    --   local colors = require("catppuccin.palettes.mocha")
    --   local helpers = require("incline.helpers")
    --   require("incline").setup({
    --     highlight = {
    --       groups = {
    --         -- InclineNormal = { guibg = "#FC56B1", guifg = colors.base },
    --         -- InclineNormalNC = { guifg = "#FC56B1", guibg = colors.base },
    --         -- NavicText = { guibg = "#FC56B1", guifg = colors.base },
    --         NavicText = { guifg = "#FC56B1" },
    --       },
    --     },
    --     window = { margin = { vertical = 0, horizontal = 1 } },
    --     render = function(props)
    --       local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    --       if filename == "" then
    --         filename = "[No Name]"
    --       end
    --       local navic = require("nvim-navic")
    --       local devicons = require("nvim-web-devicons")
    --       local ft_icon, ft_color = devicons.get_icon_color(filename)
    --       local modified = vim.bo[props.buf].modified
    --       local res = {
    --         ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
    --         " ",
    --         { filename, gui = modified and "bold,italic" or "bold" },
    --         -- guibg = "#FC56B1",
    --         -- guifg = colors.base,
    --       }
    --       if props.focused then
    --         for _, item in ipairs(navic.get_data(props.buf) or {}) do
    --           table.insert(res, {
    --             { " > ", group = "NavicSeparator" },
    --             { item.icon, group = "NavicIcons" .. item.type },
    --             { item.name, group = "NavicText" },
    --           })
    --         end
    --       end
    --       table.insert(res, " ")
    --       return res
    --     end,
    --   })
    -- end,
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
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    keys = {
      { "<Leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle ZenMode" },
    },
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
  --       context = 10,
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     })
  --   end,
  -- },
  --
  -- scrollbar
  -- {
  --   "nvim-zh/colorful-winsep.nvim",
  --   config = true,
  --   event = { "WinNew" },
  -- },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
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
