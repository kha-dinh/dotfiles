return {
  {
    "neovim/nvim-lspconfig",
    version = "0.1.9",
    dependencies = {
      {
        -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        -- config = function()
        --   require("lsp_lines").setup()
        -- end,
      },

      {
        "kosayoda/nvim-lightbulb",
        dependencies = "antoinemadec/FixCursorHold.nvim",
      },
      {
        "f3fora/nvim-texlabconfig",
        build = "go build",
        config = function()
          require("texlabconfig").setup()
        end,
      },
    },
    -- local lsp_configurations = require("lspconfig.configs")
    -- local util = require("lspconfig.util")
    -- lsp_configurations.bibli_ls = {
    --   default_config = {
    --     name = "bibli_ls",
    --     root_dir = function(fname)
    --       local root_files = { ".marksman.toml" }
    --       return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    --     end,
    --     single_file_support = true,
    --   },
    -- }
    --   default_config = {
    --     filetypes = { "markdown" },
    --   }
    --   -- root_dir = lspconfig.util.root_pattern("go.mod"),
    --   -- settings = {},
    -- },
    -- local on_attach = function(client, bufnr)
    --   -- keymaps
    -- end
    --
    -- require("lspconfig").bibli_is.setup({
    --   on_attach = on_attach,
    -- })
    opts = {

      servers = {

        -- clangd = {
        --   mason = true,
        --   on_attach = function(_, _) end,
        -- },
        -- rust_analyzer = {
        --   settings = {
        --     rust_analyzer = {
        --       editor = {
        --         quickSuggestionDelay = 200,
        --       },
        --     },
        --   },
        -- },
        --   ltex = {lsp
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
        --
        -- markdownlint = {
        --   filetypes = { "pandoc", "markdown" },
        -- },
        -- bibli_ls = {},
        -- textlsp = {
        --   filetypes = { "tex", "latex", "pandoc", "markdown" },
        --   settings = {
        --     textLSP = {
        --       analysers = {
        --         languagetool = {
        --           enabled = false,
        --           check_text = {
        --             on_open = true,
        --             on_save = true,
        --             on_change = false,
        --           },
        --         },
        --         ollama = {
        --           enabled = true,
        --           check_text = {
        --             on_open = true,
        --             on_save = true,
        --             on_change = false,
        --           },
        --           model = "phi3:3.8b-instruct", -- smaller but faster model
        --           -- model = "phi3:14b-instruct",  -- more accurate
        --           max_token = 50,
        --         },
        --       },
        --     },
        --   },
        -- },
        -- grammarly = {
        --   filetypes = { "tex", "latex", "pandoc", "markdown" },
        -- },
        -- vale = {
        --   filetypes = { "tex", "latex", "pandoc", "markdown" },
        -- },
        -- vale_ls = {
        --   filetypes = { "pandoc", "markdown" },
        -- },
        --
        -- ltex = {
        --   settings = {
        --     ltex = {
        --       checkFrequency = "save",
        --       sentenceCacheSize = 10000,
        --     },
        --   },
        -- },
        harper_ls = {
          settings = {
            ["harper-ls"] = {
              markdown = {
                IgnoreLinkTitle = true,
              },
            },
          },
        },
        texlab = {
          on_attach = function(_, _)
            vim.keymap.set("n", "<Leader>tf", "<cmd>TexlabForward<cr>")
            vim.keymap.set("n", "<Leader>tb", "<cmd>TexlabBuild<cr>")
          end,
          settings = {
            texlab = {
              forwardSearch = {
                executable = "sioyek",
                args = {
                  "--reuse-window",
                  "--execute-command",
                  "toggle_synctex",
                  "--inverse-search",
                  "nvim-texlabconfig -file %%%1 -line %%%2",
                  "--forward-search-file",
                  "%f",
                  "--forward-search-line",
                  "%l",
                  "%p",
                },
              },
              -- auxDirectory = "build", -- IMPORTANT
              build = {
                onSave = true,
                -- Added -bibtex, --shell-escape
                args = {
                  "-pdf",
                  "-bibtex",
                  "--shell-escape",
                  "-interaction=nonstopmode",
                  "-synctex=1",
                  "%f",
                  -- "-outdir=build",
                },
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
      -- setup = {
      -- Fix clangd offset encoding  https://www.lazyvim.org/configuration/recipes
      -- clangd = function(client, opts)
      --   opts.capabilities.offsetEncoding = { "utf-16" }
      --   -- opts.on_attach = function(client, bufnr)
      --   --   require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,
      --   --   require("navigator.dochighlight").documentHighlight(bufnr)
      --   --   require("navigator.codeAction").code_action_prompt(bufnr)
      --   -- end
      --
      --   vim.keymap.set("n", "<Leader>fh", "<cmd>ClangdSwitchSourceHeader<cr>")
      --   require("clangd_extensions").setup(opts)
      --   return true
      -- end,
      -- rust_analyzer = function(_, opts)
      --   local rt = require("rust-tools")
      --
      --   opts.on_attach = function(_, bufnr)
      --     -- Hover actions
      --     vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      --     -- Code action groups
      --     vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      --   end
      --
      --   rt.setup(opts)
      --   return true
      -- end,
      -- ltex = function(_, opts)
      --   -- table.insert(opts.filetypes, pos, value)
      --   -- print(vim.inspect(opts))
      --   return true
      -- end,
      -- },
    },
  },
  {
    -- ltex_extra to support dictionaries
    "barreiroleo/ltex_extra.nvim",
    ft = { "markdown", "tex" },
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      {},
      server_opts = {
        capabilities = {},
        on_attach = function(client, bufnr)
          -- your on_attach process
        end,
        settings = {
          ltex = {
            checkFrequency = "save",
            sentenceCacheSize = 10000,
            -- checkFrequency = "save",
          },
        },
      },
    },
    -- yes, you can use the opts field, just I'm showing the setup explicitly

    -- config = function()
    --   require("ltex_extra").setup({
    --     {},
    --     server_opts = {
    --       capabilities = {},
    --       on_attach = function(client, bufnr)
    --         -- your on_attach process
    --       end,
    --       settings = {
    --         ltex = {
    --           checkFrequency = "save",
    --           sentenceCacheSize = 10000,
    --           -- checkFrequency = "save",
    --         },
    --       },
    --     },
    --   })
    -- end,
  },
}
