return {

  {
    "lervag/vimtex",
    keys = {
      { "<localLeader>l", "", desc = "+vimtext" },
    },
    -- keys = {
    --   { "<leader>lv", "<cmd>VimtexView<cr>", desc = "VimtexView" },
    --   { "<leader>lc", "<cmd>VimtexCompile<cr>", desc = "VimtexCompile" },
    -- },
    -- lazy = false, -- lazy-loading will disable inverse search
    config = function()
      -- vim.api.nvim_create_autocmd({ "FileType" }, {
      --   group = vim.api.nvim_create_augroup("lazyvim_vimtex_conceal", { clear = true }),
      --   pattern = { "bib", "tex" },
      --   callback = function()
      --     vim.wo.conceallevel = 2
      --   end,
      -- })

      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

      vim.g.vimtex_view_general_viewer = "sioyek"
      local options = string.format(
        '--reuse-window --inverse-search="nvr --servername %s +%%2 %%1" --execute-command toggle_synctex --forward-search-file @tex --forward-search-line @line @pdf',
        vim.v.servername
      )
      local command = string.format("let g:vimtex_view_general_options='%s'", options)
      vim.cmd(command)
      vim.cmd("let g:vimtex_compiler_progname='nvr'")
      -- local options =
      --   '--reuse-window --inverse-search="nvr --servername %s +%%2 %%1" --forward-search-file @tex --forward-search-line @line @pdf'
    end,
  },
  -- {
  --   "rudism/telescope-dict.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   keys = {
  --     {
  --       "<leader>td",
  --       function()
  --         require("telescope").extensions.dict.synonyms()
  --       end,
  --       mode = "n",
  --       desc = "Find symnonyms",
  --     },
  --   },
  -- },
  -- {
  --   "brymer-meneses/grammar-guard.nvim",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --   },
  --   config = function()
  --     require("grammar-guard").init()
  --     require("lspconfig").grammar_guard.setup({
  --       cmd = { "ltex-ls" },
  --       settings = {
  --         ltex = {
  --           enabled = { "latex", "tex", "bib", "markdown" },
  --           language = "en",
  --           diagnosticSeverity = "information",
  --           sentenceCacheSize = 4000,
  --           completionEnabled = true,
  --           additionalRules = {
  --             enablePickyRules = false,
  --             motherTongue = "en",
  --           },
  --           checkFrequency = "save",
  --           dictionary = {},
  --           disabledRules = {},
  --           hiddenFalsePositives = {},
  --         },
  --       },
  --     })
  --   end,
  -- },
}
