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

vim.g["zk_preview_enabled"] = false

local function zk_preview()
  if vim.g["zk_preview_enabled"] then
    local file_path = vim.fn.expand("%:p")
    local home_dir = vim.env.ZK_NOTEBOOK_DIR
    vim.print(file_path)
    if string.find(file_path, "^" .. home_dir) then
      -- Extract the relative path by removing the home_dir prefix
      local relative_path = string.sub(file_path, #home_dir + 2) -- +2 to account for trailing slash
      -- Remove the file extension
      relative_path = string.gsub(relative_path, "%.%w+$", "")
      local url = "http://localhost:5000/" .. relative_path
      -- Choose the appropriate command based on your OS
      -- For Linux:
      vim.fn.jobstart({ "falkon", "-c", url })
    end
  end
end

-- Create an autocmd that triggers when opening markdown files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = zk_preview,
})
local function enable_md_preview()
  if vim.g["zk_preview_enabled"] ~= true then
    vim.g["zk_preview_enabled"] = true
    vim.notify("ZK preview enabled", vim.log.levels.INFO)
    zk_preview()
  end
end

-- Function to disable the autocmd
local function disable_md_preview()
  if vim.g["zk_preview_enabled"] then
    vim.g["zk_preview_enabled"] = false
    vim.notify("ZK preview disabled", vim.log.levels.INFO)
  end
end

-- Function to toggle the autocmd
local function toggle_md_preview()
  if vim.g["zk_preview_enabled"] then
    disable_md_preview()
  else
    enable_md_preview()
  end
end

-- Create user commands
vim.api.nvim_create_user_command("ZkPreviewEnable", enable_md_preview, {})
vim.api.nvim_create_user_command("ZkPreviewDisable", disable_md_preview, {})
vim.api.nvim_create_user_command("ZkPreviewToggle", toggle_md_preview, {})

-- Optional: You can enable it by default if you want
-- enable_md_preview()
