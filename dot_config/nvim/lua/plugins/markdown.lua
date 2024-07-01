return {
  {
    "dhruvasagar/vim-table-mode",
  },

  {
    "preservim/vim-pencil",
  },
  -- {
  --   "vim-pandoc/vim-pandoc",
  --   dependencies = {
  --     {
  --       "vim-pandoc/vim-pandoc-syntax",
  --     },
  --   },
  --   config = function()
  --     -- vim.vim["#pandoc#biblio#sources"] = "cG"
  --     -- Must be absolute path
  --     -- TODO: automatically find bibfiles in note dir
  --     -- TODO: this still doesn't work.
  --     -- vim.g["pandoc#biblio#bibs"] = { "/home/khadd/mynotes/references.bib" }
  --     --
  --   end,
  -- },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  -- {
  --   -- dir = "~/projects/cmp-pandoc.nvim",
  --   -- dev = true,
  --   "kha-dinh/cmp-pandoc.nvim",
  --   dependencies = {
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     local cmp = require("cmp")
  --     local conf = cmp.get_config()
  --     table.insert(conf.sources, { name = "cmp_pandoc" })
  --     require("cmp").setup(conf)
  --     require("cmp_pandoc").setup()
  --   end,
  --   -- opts = function(_, opts)
  --   --   local cmp = require("cmp")
  --   --   opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "cmp_pandoc" } }))
  --   --   return opts
  --   -- end,
  -- },

  {
    "jakewvincent/mkdnflow.nvim",
    rocks = "luautf8", -- Ensures optional luautf8 dependency is installed
    config = function()
      require("mkdnflow").setup({
        perspective = {
          priority = "root",
          root_tell = "index.md",
        },
        links = {
          create_on_follow_failure = false,
          conceal = true,
        },
        mappings = {
          MkdnEnter = { { "n", "v" }, "<CR>" },
          MkdnTab = false,
          MkdnSTab = false,
          MkdnNextLink = { "n", "<Tab>" },
          MkdnPrevLink = { "n", "<S-Tab>" },
          MkdnNextHeading = { "n", "]]" },
          MkdnPrevHeading = { "n", "[[" },
          MkdnGoBack = { "n", "<BS>" },
          MkdnGoForward = { "n", "<Del>" },
          MkdnCreateLink = false, -- see MkdnEnter
          MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>p" }, -- see MkdnEnter
          MkdnFollowLink = false, -- see MkdnEnter
          MkdnDestroyLink = { "n", "<M-CR>" },
          MkdnTagSpan = { "v", "<M-CR>" },
          MkdnMoveSource = { "n", "<F2>" },
          MkdnYankAnchorLink = { "n", "yaa" },
          MkdnYankFileAnchorLink = { "n", "yfa" },
          MkdnIncreaseHeading = { "n", "+" },
          MkdnDecreaseHeading = { "n", "-" },
          MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
          MkdnNewListItem = false,
          MkdnNewListItemBelowInsert = { "n", "o" },
          MkdnNewListItemAboveInsert = { "n", "O" },
          MkdnExtendList = false,
          MkdnUpdateNumbering = { "n", "<leader>nn" },
          MkdnTableNextCell = { "i", "<Tab>" },
          MkdnTablePrevCell = { "i", "<S-Tab>" },
          MkdnTableNextRow = false,
          MkdnTablePrevRow = { "i", "<M-CR>" },
          MkdnTableNewRowBelow = { "n", "<leader>ir" },
          MkdnTableNewRowAbove = { "n", "<leader>iR" },
          MkdnTableNewColAfter = { "n", "<leader>ic" },
          MkdnTableNewColBefore = { "n", "<leader>iC" },
          MkdnFoldSection = { "n", "<leader>f" },
          MkdnUnfoldSection = { "n", "<leader>F" },
        },
      })
    end,
  },
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   event = "BufRead",
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },
  -- {
  --   "preservim/vim-markdown",
  --   dependencies = { "godlygeek/tabular" },
  --   event = "VeryLazy",
  --   config = function()
  --     vim.g.vim_markdown_folding_disabled = 1
  --     vim.g.vim_markdown_conceal = 1
  --     vim.g.tex_conceal = ""
  --     vim.g.vim_markdown_math = 1
  --     vim.g.vim_markdown_frontmatter = 1
  --     vim.g.vim_markdown_toml_frontmatter = 1
  --     vim.g.vim_markdown_json_frontmatter = 1
  --   end,
  -- },
  -- {
  --   -- Copied from https://www.lazyvim.org/extras/lang/markdown
  --   "lukas-reineke/headlines.nvim",
  --   opts = function()
  --     local opts = {}
  --     for _, ft in ipairs({ "markdown", "norg", "rmd", "org" }) do
  --       opts[ft] = {
  --         headline_highlights = {},
  --         -- disable bullets for now. See https://github.com/lukas-reineke/headlines.nvim/issues/66
  --         bullets = {},
  --       }
  --       for i = 1, 6 do
  --         local hl = "Headline" .. i
  --         vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
  --         table.insert(opts[ft].headline_highlights, hl)
  --       end
  --     end
  --     return opts
  --   end,
  --   ft = { "markdown", "norg", "rmd", "org" },
  --   config = function(_, opts)
  --     -- PERF: schedule to prevent headlines slowing down opening a file
  --     vim.schedule(function()
  --       require("headlines").setup(opts)
  --       require("headlines").refresh()
  --     end)
  --   end,
  -- },
  --
  -- {
  --   "stevearc/conform.nvim",
  --   opts = function(_, opts)
  --     opts.formatters["markdown-toc"] = {
  --       condition = function(_, ctx)
  --         for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
  --           if line:find("<!%-%- toc %-%->") then
  --             return true
  --           end
  --         end
  --       end,
  --     }
  --     opts.formatters["markdownlint-cli2"] = {
  --       condition = function(_, ctx)
  --         local diag = vim.tbl_filter(function(d)
  --           return d.source == "markdownlint"
  --         end, vim.diagnostic.get(ctx.buf))
  --         return #diag > 0
  --       end,
  --     }
  --     opts.formatters_by_ft["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" }
  --     opts.formatters_by_ft["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" }
  --   end,
  -- },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = vim.list_extend(opts.sources or {}, {
  --       nls.builtins.diagnostics.markdownlint_cli2,
  --     })
  --   end,
  -- },
  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.linters_by_ft["markdown"] = { "markdownlint-cli2" }
  --   end,
  -- },
}
