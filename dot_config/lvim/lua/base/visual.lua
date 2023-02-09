require("catppuccin").setup()
vim.g.catppuccin_flavour = "macchiato"
lvim.colorscheme = "catppuccin"

vim.opt.guifont = { "source code pro", "h12" }
vim.g["neovide_transparency"] = 1

-- Text wrap
vim.cmd(":set wrap")

-- relative line number
vim.cmd(":set number relativenumber")


lvim.format_on_save = false
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.terminal.direction = "tab"
lvim.builtin.nvimtree.setup.view.side = "left"


lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.ensure_installed = {
  "rust",
  "bash",
  "c",
  "cpp",
  "json",
  "lua",
  "python",
  "yaml",
  "latex",
}

local _, map = pcall(require, "mini.map")
-- https://www.lunarvim.org/docs/plugins/extra-plugins
lvim.autocommands = {
  {
    { "BufEnter", "Filetype", "VimResized" },
    {
      desc = "Open mini.map and exclude some filetypes",
      pattern = { "*" },
      callback = function()
        local exclude_ft = {
          "qf",
          "NvimTree",
          "toggleterm",
          "TelescopePrompt",
          "alpha",
          "netrw",
        }

        local winwidth = vim.fn.winwidth(0)
        if vim.tbl_contains(exclude_ft, vim.o.filetype) then
          vim.b.minimap_disable = true
          map.close()
        elseif vim.o.buftype == "" then
          if winwidth > 100 then
            map.open()
          else
            map.close()
          end
        end
      end,
    },
  },

}
