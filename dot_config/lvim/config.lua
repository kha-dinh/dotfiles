--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
vim.cmd(":set wrap")
vim.cmd(":set number relativenumber")

vim.api.nvim_set_keymap("", "<leader>y", '"+y', { silent = true })

vim.g["neovide_transparency"] = 1
-- general
lvim.log.level = "warn"
lvim.format_on_save = false

lvim.builtin.bufferline.tabpages = true



-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- Remap enter to tab
-- lvim.builtin.cmp.mapping["<Tab>"] = lvim.builtin.cmp.mapping["<CR>"]
lvim.builtin.comment.mappings.extra = true



local cmp = require "cmp"
lvim.builtin.cmp.mapping['<TAB>'] = cmp.mapping.confirm({ select = true })
-- local _, lightspeed = pcall(require, "lightspeed")
-- lightspeed.setup {}

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["t"] = {
  name = "+tabs",
  n = { "<cmd>tabnext<cr>", "next tab" },
  l = { "<cmd>tabs<cr>", "show tab pages" }
}

lvim.builtin.which_key.mappings["b"]["b"] = { "<C-^>", "Previous Buffer" }


lvim.builtin.which_key.mappings["T"] = {
  name = "+Telescope",
  b = { "<cmd>Telescope buffers<cr>", "Telescope buffers" },
  f = { "<cmd>Telescope find_files<cr>", "Telescope find files" },
  p = { "<cmd>Telescope projects<cr>", "Telescope find projects" },
  r = { "<cmd>Telescope oldfiles<cr>", "Telescope find recents" },
  g = { "<cmd>Telescope live_grep<cr>", "Telescope live_grep" },
}
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.builtin.which_key.mappings["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy find current buffer" }

-- lvim.builtin.which_key.mappings["_"] =  {"<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy find current buffer"}
-- lvim.keys.normal_mode["<leader>"] =

lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "tab"
lvim.builtin.project.active = true
lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.filters.exclude = { ".o"}

require('telescope').load_extension('projects')
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true


lvim.plugins = {
  { "folke/tokyonight.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("telescope").load_extension('harpoon')
      lvim.builtin.which_key.mappings["m"] = {
        name = "+Harpoon",
        f = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark the file" },
        n = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Move to next mark" },
        p = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Move to previous mark" },
        t = { "<cmd>Telescope harpoon marks<cr>", "Show marks" },
        ["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Navigate to file 1" },
        ["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Navigate to file 2" },
        ["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Navigate to file 3" },
        ["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Navigate to file 4" }
      }
    end,
  },
  { "preservim/vim-pencil" },
  { "ggandor/lightspeed.nvim" },
  { "kdheepak/lazygit.nvim" },
  { "rhysd/vim-llvm" },
  {
    'lervag/vimtex',
    config = function()
      vim.cmd("syntax enable")
      -- vim.cmd("let g:vimtex_view_general_viewer = 'okular'")
      vim.cmd("let g:vimtex_view_method= 'zathura'")

      lvim.builtin.which_key.mappings["v"] = {
        name = "+VimTex",
        v = { "<cmd>VimtexView<cr>", "View" },
        c = { "<cmd>VimtexCompile<cr>", "Compile" },
        C = { "<cmd>VimtexClean<cr>", "Clean" }
      }
      -- vim.cmd("let g:vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'")
      -- vim.cmd("let g:vimtex_view_general_viewer = 'okular'")
      -- vim.cmd("let g:vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'")
      -- vim.cmd("let g:vimtex_view_general_options_latexmk = '--unique'")
    end,
  },
  -- {
  --   "tzachar/cmp-tabnine",
  --   run = "./install.sh",
  --   requires = "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  -- },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = false
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".setup()
    end
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  }

}

-- lvim.colorscheme = "tokyonight"
lvim.colorscheme = "gruvbox"
vim.g["gruvbox_contrast_dark"] = "soft"
vim.g["gruvbox_improved_strings"] = 0
vim.g["gruvbox_improved_warnings"] = 1

vim.opt.guifont = { "Source Code Pro", "h12" }


-- some settings can only passed as commandline flags `clangd --help`

-- require("lvim.lsp.manager").setup("clangd", opts)

