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
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.luasnip.sources.friendly_snippets = true
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "tab"
lvim.builtin.terminal.open_mapping = "<C-t>"
lvim.builtin.dap.active = true
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
  "cpp",
  "json",
  "lua",
  "python",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }

lvim.plugins = {
  { "ThePrimeagen/harpoon", },
  { "preservim/vim-pencil" },
  { "ggandor/lightspeed.nvim" },
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
    "ray-x/lsp_signature.nvim"
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
    end
    -- ft = { "rust", "rs" },
  },
  {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
  },
  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "LudoPinelli/comment-box.nvim"
  }
}
require "lsp_signature".setup({
  bind = true,
  handler_opts = { border = "rounded" }
})


vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
  return
end
local opts = {
  tools = {
    executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
    reload_workspace_from_cargo_toml = true,
    inlay_hints = {
      auto = true,
      only_current_line = false,
      show_parameter_hints = false,
      parameter_hints_prefix = "<-",
      other_hints_prefix = "=>",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment",
    },
    hover_actions = {
      --border = {
      --        { "╭", "FloatBorder" },
      --        { "─", "FloatBorder" },
      --        { "╮", "FloatBorder" },
      --        { "│", "FloatBorder" },
      --        { "╯", "FloatBorder" },
      --        { "─", "FloatBorder" },
      --        { "╰", "FloatBorder" },
      --        { "│", "FloatBorder" },
      --},
      auto_focus = true,
    },
  },
  server = {
    on_attach = require("lvim.lsp").common_on_attach,
    on_init = require("lvim.lsp").common_on_init,
    -- settings = {
    --   ["rust-analyzer"] = {
    --     checkOnSave = {
    --       command = "clippy"
    --     }
    --   }
    -- },
  },
}

-- local path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/")
--     or vim.fn.expand "~/" .. ".vscode/extensions/vadimcn.vscode-lldb-1.7.4/"
-- local codelldb_path = path .. "adapter/codelldb"
-- local liblldb_path = path .. "lldb/lib/liblldb.so"

-- if vim.fn.has "mac" == 1 then
--   liblldb_path = path .. "lldb/lib/liblldb.dylib"
-- end

-- if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
--   opts.dap = {
--     adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
--   }
-- end
rust_tools.setup(opts)

-- require("gruvbox").setup({
--   contrast="soft",
-- })

require("catppuccin").setup()
vim.g.catppuccin_flavour = "macchiato"
lvim.colorscheme = "catppuccin"


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
