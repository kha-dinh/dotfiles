return {
  -- add symbols-outline
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "kosayoda/nvim-lightbulb",
        dependencies = "antoinemadec/FixCursorHold.nvim",
      },
      {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
        keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
        opts = {
          -- add your options that should be passed to the setup() function here
          position = "right",
        },
      },
      {
        "simrat39/rust-tools.nvim",
      },
      {
        "f3fora/nvim-texlabconfig",
        build = "go build",
        config = function()
          require("texlabconfig").setup()
        end,
      },
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
    autoformat = false,
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        clangd = {
          mason = false,
          on_attach = function(_, _)
            vim.keymap.set("n", "<Leader>fh", "<cmd>ClangdSwitchSourceHeader<cr>")
          end,
        },
        rust_analyzer = {
          settings = {
            rust_analyzer = {
              editor = {
                quickSuggestionDelay = 200,
              },
            },
          },
        },
        -- ltex = {
        -- settings = {
        --   ltex = {
        --     enabled = { "latex", "tex", "bib", "markdown" },
        --     language = "en",
        --     diagnosticSeverity = "information",
        --     sentenceCacheSize = 4000,
        --     completionEnabled = true,
        --     additionalRules = {
        --       enablePickyRules = true,
        --       motherTongue = "en",
        --     },
        --     checkFrequency = "save",
        --     dictionary = {},
        --     disabledRules = {
        --       en = {
        --         "APOS_SPACE_CONTRACTION",
        --         "UPPERCASE_SENTENCE_START",
        --         "COMMA_PARENTHESIS_WHITESPACE",
        --       },
        --     },
        --     hiddenFalsePositives = {},
        --   },
        -- },
        -- },
        grammarly = {
          filetypes = { "tex" },
        },
        texlab = {
          on_attach = function(_, _)
            vim.keymap.set("n", "<Leader>vf", "<cmd>TexlabForward<cr>")
            vim.keymap.set("n", "<Leader>vb", "<cmd>TexlabBuild<cr>")
          end,
          settings = {
            texlab = {
              forwardSearch = {
                executable = "sioyek",
                args = {
                  "--reuse-window",
                  "--inverse-search",
                  [[nvim-texlabconfig -file %1 -line %2]],
                  "--forward-search-file",
                  "%f",
                  "--forward-search-line",
                  "%l",
                  "%p",
                },
              },
              build = {
                onSave = true,
                -- Added -bibtex, --shell-escape
                args = { "-pdf", "-bibtex", "--shell-escape", "-interaction=nonstopmode", "-synctex=1", "%f" },
              },
              chktex = {
                onOpenAndSave = true,
                onEdit = false,
              },
            },
          },
        },
      },
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- Fix clangd offset encoding  https://www.lazyvim.org/configuration/recipes
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
        rust_analyzer = function(_, opts)
          local rt = require("rust-tools")

          opts.on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          end

          rt.setup(opts)
          return true
        end,
        ltex = function(_, opts)
          -- table.insert(opts.filetypes, pos, value)
          -- print(vim.inspect(opts))
          return true
        end,
      },
    },
  },
}
