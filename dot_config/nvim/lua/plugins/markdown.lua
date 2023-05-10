return {
  {
    "dhruvasagar/vim-table-mode",
  },
  {
    "vim-pandoc/vim-pandoc",
    dependencies = {
      {
        "vim-pandoc/vim-pandoc-syntax",
      },
    },
    config = function()
      -- vim.vim["#pandoc#biblio#sources"] = "cG"
      -- Must be absolute path
      -- TODO: automatically find bibfiles in note dir
      -- TODO: this still doesn't work.
      -- vim.g["pandoc#biblio#bibs"] = { "/home/khadd/mynotes/references.bib" }
      vim.g["pandoc#biblio#use_bibtool"] = 1
    end,
  },
  {

    dir = "~/projects/cmp-pandoc.nvim",
    dev = true,
    dependencies = {
      "kha-dinh/cmp-pandoc.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local conf = cmp.get_config()
      table.insert(conf.sources, { name = "cmp_pandoc" })
      require("cmp").setup(conf)
      require("cmp_pandoc").setup()
    end,
    -- opts = function(_, opts)
    --   local cmp = require("cmp")
    --   opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "cmp_pandoc" } }))
    --   return opts
    -- end,
  },

  {
    "jakewvincent/mkdnflow.nvim",
    rocks = "luautf8", -- Ensures optional luautf8 dependency is installed
    config = function()
      require("mkdnflow").setup({
        perspective = {
          priority = "root",
          root_tell = "index.md",
        },
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
  },
  {
    "preservim/vim-markdown",
    dependencies = { "godlygeek/tabular" },
    event = "VeryLazy",
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0
      vim.g.tex_conceal = ""
      vim.g.vim_markdown_math = 1
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_toml_frontmatter = 1
      vim.g.vim_markdown_json_frontmatter = 1
    end,
  },
}
