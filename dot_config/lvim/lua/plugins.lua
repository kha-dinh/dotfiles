-- any lvim-specific  or cross-plugin configuration should not be done here
lvim.plugins = {
    { "ThePrimeagen/harpoon", },
    { "preservim/vim-pencil", },
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function()
          require("todo-comments").setup()
        end,
    },
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
          require('neoscroll').setup({
              -- All these keys will be mapped to their corresponding default scrolling animation
              mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
                  '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
              hide_cursor = true, -- Hide cursor while scrolling
              stop_eof = true, -- Stop at <EOF> when scrolling downwards
              use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
              respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
              cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
              easing_function = "sine", -- Default easing function
              pre_hook = nil, -- Function to run before the scrolling animation starts
              post_hook = nil, -- Function to run after the scrolling animation ends
          })
          local t = {}
          t['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '100' } }
          t['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '100' } }
          t['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '100' } }
          t['<C-f>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '100' } }
          t['<C-y>'] = { 'scroll', { '-0.10', 'false', '100' } }
          t['<C-e>'] = { 'scroll', { '0.10', 'false', '100' } }
          t['zt'] = { 'zt', { '100' } }
          t['zz'] = { 'zz', { '100' } }
          t['zb'] = { 'zb', { '100' } }

          require('neoscroll.config').set_mappings(t)
        end
    },
    { "ggandor/lightspeed.nvim",
        event = "BufRead"
    },
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = "markdown",
        config = function()
          vim.g.mkdp_auto_start = 1
        end,
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
        'f3fora/nvim-texlabconfig',
        config = function()
          local config = {}
          require('texlabconfig').setup(config)
        end,
        -- ft = { 'tex', 'bib' }, -- for lazy loading
        build = 'go build -o  ~/.local/bin'
        -- run = 'go build -o ~/.bin/' if e.g. ~/.bin/ is in $PATH
    },
    {
        'lervag/vimtex',
        ft = { 'tex', 'bib' }, -- for lazy loading
        config = function()
          vim.cmd("syntax enable")
          vim.cmd("let g:vimtex_view_general_viewer='sioyek'")
          -- %1: file, %2: line number
          local options =
              string.format(
                  '--reuse-window --inverse-search="nvr --servername %s +%%2 %%1" --forward-search-file @tex --forward-search-line @line @pdf',
                  vim.v.servername)

          local command = string.format(
                  "let g:vimtex_view_general_options='%s'",
                  options)
          vim.cmd(command)
          -- vim.cmd("let g:vimtex_view_method='zathura'")
          vim.cmd("let g:vimtex_compiler_progname='nvr'")
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
        "simrat39/symbols-outline.nvim",
        config = function()
          require('symbols-outline').setup()
        end
    },
    {
        'kosayoda/nvim-lightbulb',
        dependencies = 'antoinemadec/FixCursorHold.nvim',
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
