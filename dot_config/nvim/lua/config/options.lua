-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- local opt = vim.opt
-- vim.cmd([[
-- set backupdir=~/.vim/backup//
-- set undodir=~/.vim/undo//
-- ]])

-- vim.diagnostic.config({
--   virtual_text = {
--     -- source = "always",  -- Or "if_many"
--     prefix = "●", -- Could be '■', '▎', 'x'
--   },
--   severity_sort = true,
--   float = {
--     source = "always", -- Or "if_many"
--   },
-- })
-- opt.wrap = true
-- vim.g.autoformat = false
-- vim.b.noswapfile = true
--
-- vim.g["pandoc#biblio#use_bibtool"] = 1
-- vim.g["pandoc#filetypes#handled"] = { "pandoc", "markdown" }
-- vim.g["pandoc#filetypes#pandoc_markdown"] = 0
vim.o.guifont = "JetBrainsMono Nerd Font"

vim.o.spell = false

local map = vim.keymap.set

-- https://github.com/neovide/neovide/issues/1272
local function NeovideScale(amount)
  local temp = vim.g.neovide_scale_factor + amount

  if temp < 0.5 then
    return
  end

  vim.g.neovide_scale_factor = temp
end

map("n", "<C-+>", function()
  NeovideScale(0.1)
end)

map("n", "<C-->", function()
  NeovideScale(-0.1)
end)
vim.opt.relativenumber = true

vim.o.termguicolors = true
vim.g.maplocalleader = ";"

vim.g["vimtex_view_method"] = "zathura"
vim.g["vimtex_quickfix_mode"] = 0
-- vim.g["vimtex_view_skim_sync"] = 1
-- vim.g["wimtex_view_skim_activate"] = 1
vim.g["vimtex_mappings_enabled"] = 1
vim.g["vimtex_indent_enabled"] = 1
vim.g["vimtex_syntax_enabled"] = 1
vim.g["vimtex_log_ignore"] = {
  "Underfull",
  "Missing character",
  "Overfull",
  "specifier changed to",
  "Token not allowed in a PDF string",
}
-- vim.g["vimtex_context_pdf_viewer"] = "okular"

-- autocmd InsertLeave,WinEnter * setlocal foldmethod=syntax
-- autocmd InsertEnter,WinLeave * setlocal foldmethod=manual
