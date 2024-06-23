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
