local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

local function symbol_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local clangd_client = util.get_active_client_by_name(bufnr, "clangd")
  if not clangd_client or not clangd_client.supports_method("textDocument/symbolInfo") then
    return vim.notify("Clangd client not found", vim.log.levels.ERROR)
  end
  local params = vim.lsp.util.make_position_params()
  clangd_client.request("textDocument/symbolInfo", params, function(err, res)
    if err or #res == 0 then
      -- Clangd always returns an error, there is not reason to parse it
      return
    end
    local container = string.format("container: %s", res[1].containerName) ---@type string
    local name = string.format("name: %s", res[1].name) ---@type string
    vim.lsp.util.open_floating_preview({ name, container }, "", {
      height = 2,
      width = math.max(string.len(name), string.len(container)),
      focusable = false,
      focus = false,
      border = require("lspconfig.ui.windows").default_options.border or "single",
      title = "Symbol Info",
    })
  end, bufnr)
end

if not configs.bibli_ls then
  configs.bibli_ls = {
    default_config = {
      cmd = { "bibli_ls" },
      filetypes = { "markdown" },
      root_dir = lspconfig.util.root_pattern(".bibli.toml"),
      on_attach = function(client, bufnr)
        vim.keymap.set({ "n" }, "<cr>", function()
          vim.lsp.buf.implementation()
        end)
      end,
    },
  }
end

-- HACK: Copied from https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/ltex_plus.lua
-- while waiting for full support

if not configs.ltex_plus then
  local language_id_mapping = {
    bib = "bibtex",
    pandoc = "markdown",
    plaintex = "tex",
    rnoweb = "rsweave",
    rst = "restructuredtext",
    tex = "latex",
    text = "plaintext",
  }

  local function get_language_id(_, filetype)
    return language_id_mapping[filetype] or filetype
  end

  configs.ltex_plus = {
    default_config = {
      cmd = { "ltex-ls-plus" },
      filetypes = {
        "bib",
        "context",
        "gitcommit",
        "html",
        "markdown",
        "org",
        "pandoc",
        "plaintex",
        "quarto",
        "mail",
        "mdx",
        "rmd",
        "rnoweb",
        "rst",
        "tex",
        "text",
        "typst",
        "xhtml",
      },
      root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
      end,
      single_file_support = true,
      get_language_id = get_language_id,
      settings = {
        ltex = {
          checkFrequency = "save",
          sentenceCacheSize = 10000,
          enabled = {
            "bib",
            "context",
            "gitcommit",
            "html",
            "markdown",
            "org",
            "pandoc",
            "plaintex",
            "quarto",
            "mail",
            "mdx",
            "rmd",
            "rnoweb",
            "rst",
            "tex",
            "text",
            "typst",
            "xhtml",
          },
        },
      },
    },
    docs = {
      description = [=[
https://github.com/ltex-plus/ltex-ls-plus

LTeX Language Server: LSP language server for LanguageTool 🔍✔️ with support for LaTeX 🎓, Markdown 📝, and others

To install, download the latest [release](https://github.com/ltex-plus/ltex-ls-plus) and ensure `ltex-ls-plus` is on your path.

This server accepts configuration via the `settings` key.

```lua
  settings = {
    ltex = {
      language = "en-GB",
    },
  },
```

To support org files or R sweave, users can define a custom filetype autocommand (or use a plugin which defines these filetypes):

```lua
vim.cmd [[ autocmd BufRead,BufNewFile *.org set filetype=org ]]
```
]=],
    },
  }
end

lspconfig.bibli_ls.setup({})
-- lspconfig.ltex_plus.setup({})
--

-- Use null-ls to support image hover
local null_ls = require("null-ls")
local image_preview = {
  method = null_ls.methods.HOVER,
  filetypes = { "markdown", "text" },
  generator = {
    fn = function()
      require("snacks").image.hover()
    end,
  },
}
null_ls.register({ image_preview })
