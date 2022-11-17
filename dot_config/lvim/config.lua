vim.opt.guifont = { "source code pro", "h12" }
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
vim.cmd(":set wrap")
vim.cmd(":set number relativenumber")
vim.api.nvim_set_keymap("", "<leader>y", '"+y', { silent = true })
vim.g["neovide_transparency"] = 1

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.builtin.comment.mappings.extra = true
lvim.builtin.bufferline.tabpages = true
lvim.builtin.notify.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "tab"
lvim.builtin.terminal.open_mapping = "<C-t>"

lvim.builtin.project.active = true
lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.filters.exclude = { ".o" }


lvim.builtin.treesitter.highlight.enabled = true
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- require('telescope').load_extension('projects')
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "rust",
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

lvim.plugins = {
  -- { "folke/tokyonight.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "ThePrimeagen/harpoon", },
  { "preservim/vim-pencil" },
  { "ggandor/lightspeed.nvim" },
  -- { 'github/copilot.vim' },
  { "catppuccin/nvim" },
  { "kdheepak/lazygit.nvim" },
  { "rhysd/vim-llvm" },
  {
    'lervag/vimtex',
    config = function()
      vim.cmd("syntax enable")
      -- vim.cmd("let g:vimtex_view_general_viewer = 'okular'")
      vim.cmd("let g:vimtex_view_method= 'zathura'")
    end,
  },
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
    "ray-x/lsp_signature.nvim"
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  }

}
require "lsp_signature".setup({
  bind = true,
  handler_opts = { border = "rounded" }
})

-- require("gruvbox").setup({
--   contrast="soft",
-- })

require("catppuccin").setup()
vim.g.catppuccin_flavour = "macchiato"
lvim.colorscheme = "catppuccin"
-- lvim.colorscheme = "gruvbox"


-- require("lvim.lsp.manager").setup("ltex", {})
-- require("lvim.lsp.manager").setup("rust_analyzer", {})



-- which-key setup --
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


lvim.builtin.which_key.mappings["b"]["b"] = { "<C-^>", "Previous Buffer" }
lvim.builtin.which_key.mappings["T"] = {
  name = "+Telescope",
  b = { "<cmd>Telescope buffers<cr>", "Telescope buffers" },
  f = { "<cmd>Telescope find_files<cr>", "Telescope find files" },
  p = { "<cmd>Telescope projects<cr>", "Telescope find projects" },
  r = { "<cmd>Telescope oldfiles<cr>", "Telescope find recents" },
  g = { "<cmd>Telescope live_grep<cr>", "Telescope live_grep" },
}
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy find current buffer" }




-- which-key setup
lvim.builtin.which_key.mappings["e"] = {
  name = "+NvimTree",
  t = { "<cmd>NvimTreeToggle<cr>", "Toggle" },
  f = { "<cmd>NvimTreeFocus<cr>", "Focus" }
}

lvim.builtin.which_key.mappings["E"] = {
  name = "+NvimTree",
  t = { "<cmd>NvimTreeToggle<cr>", "Toggle" },
  f = { "<cmd>NvimTreeFocus<cr>", "Focus" }
}

lvim.builtin.which_key.mappings["l"]["h"] = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch source header" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

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
lvim.builtin.which_key.mappings["v"] = {
  name = "+VimTex",
  v = { "<cmd>VimtexView<cr>", "View" },
  c = { "<cmd>VimtexCompile<cr>", "Compile" },
  C = { "<cmd>VimtexClean<cr>", "Clean" }
}
