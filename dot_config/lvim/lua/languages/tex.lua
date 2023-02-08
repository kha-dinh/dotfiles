vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "texlab" })
vim.lsp.set_log_level("debug")

local config = {
  settings = {
    texlab = {
      rootDirectory = nil,
      build = {
        -- executable = 'latexmk',
        -- args = { "-pdf", "-file-line-error", "-interaction=nonstopmode", "-synctex=1", "-pvc" },
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-pvc" },
        onSave = true,
        forwardSearchAfter = true,
      },
      auxDirectory = '.',
      forwardSearch = {
        executable = "sioyek",
        args = {
          '--reuse-window',
          '--inverse-search',
          [[nvim-texlabconfig -file %1 -line %2]],
          '--forward-search-file', '%f',
          '--forward-search-line', '%l', '%p'
        },
        -- executable = "zathura",
        -- args = {
        --   "--synctex-forward", "%l:1:%f", "%p"
        -- },
        onSave = true,
      },
      chktex = {
        onOpenAndSave = true,
        onEdit = false,
      },
    },
  },
}

require("lvim.lsp.manager").setup("texlab", config)

-- https://github.com/latex-lsp/texlab/wiki/Configuration#texlabforwardsearchexecutable
-- zathura --synctex-forward 511:1:foo.tex foo.pdf


lvim.builtin.which_key.mappings["v"] = {
  name = "+Tex",
  v = { "<cmd>TexlabForward<cr>", "View" },
  c = { "<cmd>TexlabBuild<cr>", "Compile" },
}
-- vim.cmd("filetype plugin indent on")
-- vim.cmd("syntax enable")
-- vim.cmd("let g:vimtex_view_method='zathura'")
-- vim.cmd("let g:vimtex_enabled=1")
-- lvim.autocommands = {
--     {
--         "BufEnter", -- see `:h autocmd-events`
--         { -- this table is passed verbatim as `opts` to `nvim_create_autocmd`
--             pattern = { "*.tex", "*.md" }, -- see `:h autocmd-events`
--             command = "PencilSoft",
--         }
--     },
-- }
--
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "texlab" })
