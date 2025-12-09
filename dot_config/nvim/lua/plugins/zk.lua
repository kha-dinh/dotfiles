return {
  {
    "zk-org/zk-nvim",
    event = "VeryLazy",
    dependencies = {
      -- {
      --   "goolord/alpha-nvim",
      --   opts = function(_, dashboard)
      --     local button = dashboard.button("z", " " .. " Zk Notes", "<cmd>ZkNotes {sort={'modified'}}<CR>")
      --     button.opts.hl = "AlphaButtons"
      --     button.opts.hl_shortcut = "AlphaShortcut"
      --     table.insert(dashboard.section.buttons.val, 4, button)
      --   end,
      -- },
      {
        "folke/which-key.nvim",
        opts = function(opts)
          local wk = require("which-key")
          local keymaps = {}
          keymaps["<leader>z"] = { group = "zk" }
          keymaps["<leader>zd"] = { group = "daily" }
          keymaps["<leader>zf"] = { group = "fleeting" }
          wk.register(keymaps)
        end,
      },
      --   {
      --     "nvim-neo-tree/neo-tree.nvim",
      --     event = "VeryLazy",
      --     dependencies = {
      --       {
      --         "idanarye/neo-tree-zk.nvim",
      --         branch = "fix-modified_buffers_changes-to-opened_buffers_changed",
      --       },
      --       -- "prncss-xyz/neo-tree-zk.nvim",
      --       "zk-org/zk-nvim",
      --     },
      --     opts = function(_, opts)
      --       -- opts.zk = {
      --       --   follow_current_file = true,
      --       --   window = {
      --       --     mappings = {
      --       --       ["n"] = "change_query",
      --       --     },
      --       --   },
      --       -- }
      --       vim.list_extend(opts.sources, { "zk" })
      --       -- sources = {
      --       --   --   -- default sources
      --       --   "filesystem",
      --       --   "buffers",
      --       --   "git_status",
      --       --   "zk",
      --       -- }
      --     end,
      --   },
    },
    keys = {
      { "<leader>zn", "<cmd>ZkNew {title=vim.fn.input('Title: ')}<cr>", mode = "n", desc = "Create New Zk Note" },
      {
        "<leader>zn",
        ":'<,'>ZkNewFromTitleSelection<cr>",
        mode = "v",
        desc = "Create New Zk from selection",
      },

      {
        "<leader>zz",
        "<cmd>ZkNotes {sort={'modified'}}<cr>",
        mode = "n",
        desc = "List recent zk notes",
      },
      {
        "<leader>zr",
        "<cmd>ZkNotes {sort={'random'}, tags={'NOT archive', 'NOT daily'}}<cr>",
        mode = "n",
        desc = "List recent zk notes (random order)",
      },
      { "<leader>zt", "<cmd>ZkTags {sort={'note-count'}}<cr>", mode = "n", desc = "List Zk Tags" },
      {
        "<leader>zdn",
        ':ZkNew {dir="daily"} <cr>',
        mode = "n",
        desc = "New daily notes",
      },
      { "<leader>zdl", ':ZkNotes {hrefs={"daily"}} <cr>', mode = "n", desc = "List daily notes" },
      { "<leader>zi", ":ZkIndex <cr>", mode = "n", desc = "Reindex Zk notes" },
      { "<leader>zs", ':ZkNotes {sort = {"word-count"}} <cr>', mode = "n", desc = "Find short notes " },
      { "<leader>zb", ":ZkBacklinks <cr>", mode = "n", desc = "Current note's backlinks" },
      { "<leader>ze", ":Neotree toggle zk <cr>", mode = "n", desc = "Open Zk Neotree" },
    },
    config = function()
      local zk = require("zk")
      zk.setup({
        picker = "snacks_picker",
        -- picker = "telescope",
        -- See Setup section below
      })
      local commands = require("zk.commands")
      commands.add("ZkOrphans", function(options)
        options = vim.tbl_extend("force", { orphan = true }, options or {})
        zk.edit(options, { title = "Zk Orphans" })
      end)
    end,
  },
}
