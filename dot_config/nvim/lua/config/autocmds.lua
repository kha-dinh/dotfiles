-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- local function augroup(name)
--   return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
-- end
---- Disable autoformat for all files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "*" },
--   callback = function()
--     vim.b.autoformat = false
--   end,
-- })
--
vim.api.nvim_create_autocmd("FileType", {
  --   group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown", "tex", "pandoc" },
  callback = function()
    --     vim.opt_local.wrap = true
    vim.opt_local.spell = false
    --     -- vim.opt_local.conceallevel = 0
    --     vim.opt_local.linebreak = true
    --     vim.cmd([[
    --     " markdownWikiLink is a new region
    --     syn region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends
    --     " markdownLinkText is copied from runtime files with 'concealends' appended
    --     " syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
    --     " markdownLink is copied from runtime files with 'conceal' appended
    --     " syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal
    --    ]])
  end,
})

-- Create an autocmd that triggers when opening markdown files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = function()
    local file_path = vim.fn.expand("%:p")
    local home_dir = vim.env.ZK_NOTEBOOK_DIR
    vim.print(file_path)

    if string.find(file_path, "^" .. home_dir) then
      local filename = vim.fn.expand("%:t:r")
      local url = "http://localhost:5000/" .. filename

      -- Choose the appropriate command based on your OS
      -- For Linux:
      vim.fn.jobstart({ "falkon", "-c", url })
    end
  end,
})
