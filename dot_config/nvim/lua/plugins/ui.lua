return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  {

    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = function()
      local opts = {
        bottom = {
          {
            ft = "toggleterm",
            size = { height = 0.4 },
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          {
            ft = "noice",
            size = { height = 0.4 },
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          {
            ft = "lazyterm",
            title = "LazyTerm",
            size = { height = 0.4 },
            filter = function(buf)
              return not vim.b[buf].lazyterm_cmd
            end,
          },
          "Trouble",
          { ft = "qf", title = "QuickFix" },
          {
            ft = "help",
            size = { height = 20 },
            -- don't open help files in edgy that we're editing
            filter = function(buf)
              return vim.bo[buf].buftype == "help"
            end,
          },
          { title = "Spectre", ft = "spectre_panel", size = { height = 0.4 } },
          { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
        },
        left = {
          { title = "Neotest Summary", ft = "neotest-summary" },
          -- "neo-tree",
        },
        keys = {
          -- increase width
          ["<c-Right>"] = function(win)
            win:resize("width", 2)
          end,
          -- decrease width
          ["<c-Left>"] = function(win)
            win:resize("width", -2)
          end,
          -- increase height
          ["<c-Up>"] = function(win)
            win:resize("height", 2)
          end,
          -- decrease height
          ["<c-Down>"] = function(win)
            win:resize("height", -2)
          end,
        },
      }

      if LazyVim.has("neo-tree.nvim") then
        local pos = {
          filesystem = "left",
          buffers = "top",
          git_status = "right",
          document_symbols = "bottom",
          diagnostics = "bottom",
        }
        local sources = LazyVim.opts("neo-tree.nvim").sources or {}
        for i, v in ipairs(sources) do
          table.insert(opts.left, i, {
            title = "Neo-Tree " .. v:gsub("_", " "):gsub("^%l", string.upper),
            ft = "neo-tree",
            filter = function(buf)
              return vim.b[buf].neo_tree_source == v
            end,
            pinned = true,
            open = function()
              vim.cmd(("Neotree show position=%s %s dir=%s"):format(pos[v] or "bottom", v, LazyVim.root()))
            end,
          })
        end
      end

      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "trouble",
          filter = function(_buf, win)
            return vim.w[win].trouble
              and vim.w[win].trouble.position == pos
              and vim.w[win].trouble.type == "split"
              and vim.w[win].trouble.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
      return opts
    end,
  },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     lsp = {
  --       -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --       override = {
  --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --         ["vim.lsp.util.stylize_markdown"] = true,
  --         ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  --       },
  --     },
  --     -- you can enable a preset for easier configuration
  --     presets = {
  --       bottom_search = true, -- use a classic bottom cmdline for search
  --       command_palette = true, -- position the cmdline and popupmenu together
  --       long_message_to_split = true, -- long messages will be sent to a split
  --       inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --       lsp_doc_border = false, -- add a border to hover docs and signature help
  --     },
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     -- "rcarriga/nvim-notify",
  --   },
  -- },
  -- {
  --   "folke/edgy.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     local opts = {
  --       bottom = {
  --         {
  --           ft = "toggleterm",
  --           size = { height = 0.4 },
  --           filter = function(buf, win)
  --             return vim.api.nvim_win_get_config(win).relative == ""
  --           end,
  --         },
  --         {
  --           ft = "noice",
  --           size = { height = 0.4 },
  --           filter = function(buf, win)
  --             return vim.api.nvim_win_get_config(win).relative == ""
  --           end,
  --         },
  --         {
  --           ft = "lazyterm",
  --           title = "LazyTerm",
  --           size = { height = 0.4 },
  --           filter = function(buf)
  --             return not vim.b[buf].lazyterm_cmd
  --           end,
  --         },
  --         "Trouble",
  --         { ft = "qf", title = "QuickFix" },
  --         {
  --           ft = "help",
  --           size = { height = 20 },
  --           -- don't open help files in edgy that we're editing
  --           filter = function(buf)
  --             return vim.bo[buf].buftype == "help"
  --           end,
  --         },
  --         { title = "Spectre", ft = "spectre_panel", size = { height = 0.4 } },
  --         { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
  --       },
  --       left = {
  --         { title = "Neotest Summary", ft = "neotest-summary" },
  --         -- "neo-tree",
  --       },
  --       keys = {
  --         -- increase width
  --         ["<c-Right>"] = function(win)
  --           win:resize("width", 2)
  --         end,
  --         -- decrease width
  --         ["<c-Left>"] = function(win)
  --           win:resize("width", -2)
  --         end,
  --         -- increase height
  --         ["<c-Up>"] = function(win)
  --           win:resize("height", 2)
  --         end,
  --         -- decrease height
  --         ["<c-Down>"] = function(win)
  --           win:resize("height", -2)
  --         end,
  --       },
  --     }
  --
  --     if LazyVim.has("neo-tree.nvim") then
  --       local pos = {
  --         filesystem = "left",
  --         buffers = "top",
  --         git_status = "right",
  --         document_symbols = "bottom",
  --         diagnostics = "bottom",
  --       }
  --       local sources = LazyVim.opts("neo-tree.nvim").sources or {}
  --       for i, v in ipairs(sources) do
  --         table.insert(opts.left, i, {
  --           title = "Neo-Tree " .. v:gsub("_", " "):gsub("^%l", string.upper),
  --           ft = "neo-tree",
  --           filter = function(buf)
  --             return vim.b[buf].neo_tree_source == v
  --           end,
  --           pinned = true,
  --           open = function()
  --             vim.cmd(("Neotree show position=%s %s dir=%s"):format(pos[v] or "bottom", v, LazyVim.root()))
  --           end,
  --         })
  --       end
  --     end
  --
  --     for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
  --       opts[pos] = opts[pos] or {}
  --       table.insert(opts[pos], {
  --         ft = "trouble",
  --         filter = function(_buf, win)
  --           return vim.w[win].trouble
  --             and vim.w[win].trouble.position == pos
  --             and vim.w[win].trouble.type == "split"
  --             and vim.w[win].trouble.relative == "editor"
  --             and not vim.w[win].trouble_preview
  --         end,
  --       })
  --     end
  --     return opts
  --   end,
  -- },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
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
      local function getWords()
        return "W: " .. tostring(vim.fn.wordcount().words)
      end
      table.insert(opts.sections.lualine_x, { "filetype" })
      table.insert(opts.sections.lualine_x, { getWords })

      -- table.insert(opts.sections.lualine_x, { lspstatus })
    end,
  },
  -- -- {
  -- --   "m4xshen/smartcolumn.nvim",
  -- --   opts = {},
  -- -- },
  -- -- {
  -- --   "s1n7ax/nvim-window-picker",
  -- --   config = function()
  -- --     require("window-picker").setup({
  -- --       hint = "floating-big-letter",
  -- --       filter_rules = {
  -- --         bo = {
  -- --           filetype = { "incline", "notify", "noice", "scrollbar", "NvimSeparator" },
  -- --           buftype = { "special", "terminal" },
  -- --         },
  -- --       },
  -- --     })
  -- --   end,
  -- --   keys = {
  -- --     {
  -- --       "<leader>wp",
  -- --       function()
  -- --         local window_id = require("window-picker").pick_window()
  -- --         if window_id then
  -- --           -- local option = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(window_id), "filetype")
  -- --           -- print(option)
  -- --           vim.api.nvim_set_current_win(window_id)
  -- --         end
  -- --       end,
  -- --       "Select window",
  -- --     },
  -- --   },
  -- -- },
  -- -- {
  -- --   "b0o/incline.nvim",
  -- --   event = "BufReadPre",
  -- --   -- config = function()
  -- --   --   local colors = require("catppuccin.palettes.mocha")
  -- --   --   local helpers = require("incline.helpers")
  -- --   --   require("incline").setup({
  -- --   --     highlight = {
  -- --   --       groups = {
  -- --   --         -- InclineNormal = { guibg = "#FC56B1", guifg = colors.base },
  -- --   --         -- InclineNormalNC = { guifg = "#FC56B1", guibg = colors.base },
  -- --   --         -- NavicText = { guibg = "#FC56B1", guifg = colors.base },
  -- --   --         NavicText = { guifg = "#FC56B1" },
  -- --   --       },
  -- --   --     },
  -- --   --     window = { margin = { vertical = 0, horizontal = 1 } },
  -- --   --     render = function(props)
  -- --   --       local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
  -- --   --       if filename == "" then
  -- --   --         filename = "[No Name]"
  -- --   --       end
  -- --   --       local navic = require("nvim-navic")
  -- --   --       local devicons = require("nvim-web-devicons")
  -- --   --       local ft_icon, ft_color = devicons.get_icon_color(filename)
  -- --   --       local modified = vim.bo[props.buf].modified
  -- --   --       local res = {
  -- --   --         ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
  -- --   --         " ",
  -- --   --         { filename, gui = modified and "bold,italic" or "bold" },
  -- --   --         -- guibg = "#FC56B1",
  -- --   --         -- guifg = colors.base,
  -- --   --       }
  -- --   --       if props.focused then
  -- --   --         for _, item in ipairs(navic.get_data(props.buf) or {}) do
  -- --   --           table.insert(res, {
  -- --   --             { " > ", group = "NavicSeparator" },
  -- --   --             { item.icon, group = "NavicIcons" .. item.type },
  -- --   --             { item.name, group = "NavicText" },
  -- --   --           })
  -- --   --         end
  -- --   --       end
  -- --   --       table.insert(res, " ")
  -- --   --       return res
  -- --   --     end,
  -- --   --   })
  -- --   -- end,
  -- -- },
  -- {
  --   -- Show Colorcode with colors (e.g., Red)
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require("colorizer").setup({
  --       "*",
  --     })
  --   end,
  -- },
  -- {
  --   "anuvyklack/windows.nvim",
  --   event = "WinNew",
  --   dependencies = {
  --     { "anuvyklack/middleclass" },
  --     { "anuvyklack/animation.nvim", enabled = false },
  --   },
  --   keys = { { "<leader>Z", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
  --   config = function()
  --     vim.o.winwidth = 5
  --     vim.o.equalalways = false
  --     require("windows").setup({
  --       animation = { enable = false, duration = 50 },
  --     })
  --   end,
  -- },
  -- {
  --   "folke/zen-mode.nvim",
  --   event = "VeryLazy",
  --   keys = {
  --     { "<Leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle ZenMode" },
  --   },
  --   config = function()
  --     require("zen-mode").setup({
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     })
  --   end,
  -- },
  -- -- {
  -- --   "folke/twilight.nvim",
  -- --   config = function()
  -- --     require("twilight").setup({
  -- --       context = 10,
  -- --       -- your configuration comes here
  -- --       -- or leave it empty to use the default settings
  -- --       -- refer to the configuration section below
  -- --     })
  -- --   end,
  -- -- },
  -- --
  -- -- scrollbar
  -- -- {
  -- --   "nvim-zh/colorful-winsep.nvim",
  -- --   config = true,
  -- --   event = { "WinNew" },
  -- -- },
  -- {
  --   "lukas-reineke/virt-column.nvim",
  --   opts = { enabled = true },
  --   config = function(_, opts)
  --     require("virt-column").setup(opts)
  --   end,
  -- },
  -- -- {
  -- --   "folke/noice.nvim",
  -- --   opts = {
  -- --     presets = {
  -- --       lsp_doc_border = true,
  -- --     },
  -- --   },
  -- -- },
  -- {
  --
  --   "petertriho/nvim-scrollbar",
  --   event = "BufReadPost",
  --   config = function()
  --     local scrollbar = require("scrollbar")
  --     local colors = require("catppuccin.palettes.mocha")
  --     scrollbar.setup({
  --       handle = { color = colors.overlay0 },
  --       excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
  --       marks = {
  --         Search = { color = colors.blue },
  --         Error = { color = colors.red },
  --         Warn = { color = colors.yellow },
  --         Info = { color = colors.sky },
  --         Hint = { color = colors.teal },
  --         Misc = { color = colors.mauve },
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "Bekaboo/dropbar.nvim",
  --   -- optional, but required for fuzzy finder support
  --   event = "VeryLazy",
  --   dependencies = {
  --     "nvim-telescope/telescope-fzf-native.nvim",
  --   },
  --   keys = {
  --     {
  --       "<C-j>",
  --       function()
  --         require("dropbar.api").pick()
  --       end,
  --       desc = "Dropbar",
  --     },
  --   },
  --   -- config = function()
  --   -- vim.ui.select = require("dropbar.utils.menu").select
  --   -- end,
  -- },
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
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    keys = {
      {
        "<leader>j",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Dropbar",
      },
    },
    -- config = function()
    -- vim.ui.select = require("dropbar.utils.menu").select
    -- end,
  },
}
