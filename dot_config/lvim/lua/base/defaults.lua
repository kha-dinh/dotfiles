vim.o.autoread = true -- auto reload files

lvim.builtin.comment.mappings.extra = true
lvim.builtin.bufferline.tabpages = true
lvim.builtin.luasnip.sources.friendly_snippets = true
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.project.active = true
lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.setup.filters.exclude = { ".o" }
lvim.builtin.treesitter.highlight.enabled = true

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
