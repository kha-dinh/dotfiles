-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
--   -- enable wrap mode for json files only
--   callback = function()
--     lvim.builtin.which_key.mappings["l"]["h"] = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch source header" }
--     require("mason-lspconfig").setup_handlers({
--       ["clangd"] = function()
--         local config = {}
--         config = require("clangd_extensions").prepare(config)
--         require("lspconfig").clangd.setup(config)
--       end,
--     })
--     -- command = "setlocal wrap",
--   end
-- })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })

local opts = {
  cmd = { '/usr/bin/clangd' },
  filetypes = { 'c', 'h', 'hpp', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
}

local opts = {}
-- require("lvim.lsp.manager").setup("clangd", opts)
require("lspconfig")["clangd"].setup(opts)

lvim.builtin.which_key.mappings["l"]["h"] = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch source header" }
