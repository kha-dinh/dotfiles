-- any lvim-specific  or cross-plugin configuration should not be done here
lvim.plugins = {
  { "ThePrimeagen/harpoon", },
  { "preservim/vim-pencil" },
  { "ggandor/lightspeed.nvim",
    event = "BufRead"
  },
  {
    "echasnovski/mini.map",
    branch = "main",
    config = function()
      require('mini.map').setup()
      local map = require('mini.map')
      map.setup({
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diagnostic({
            error = 'DiagnosticFloatingError',
            warn  = 'DiagnosticFloatingWarn',
            info  = 'DiagnosticFloatingInfo',
            hint  = 'DiagnosticFloatingHint',
          }),
        },
        symbols = {
          encode = map.gen_encode_symbols.dot('4x2'),
        },
        window = {
          side = 'right',
          width = 20, -- set to 1 for a pure scrollbar :)
          winblend = 15,
          show_integration_count = false,
        },
      })

    end
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
    end,
  },
  { "catppuccin/nvim" },
  { 'honza/vim-snippets' },
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
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  {
    "simrat39/rust-tools.nvim",
    -- ft = { "rust", "rs" }, -- IMPORTANT: re-enabling this seems to break inlay-hints
    -- config = function()
    -- end,
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
  },
  {
    "ton/vim-bufsurf" -- mappings configured in base.mappings
  }
}
