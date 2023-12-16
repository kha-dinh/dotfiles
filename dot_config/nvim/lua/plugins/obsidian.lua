return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = { "pandoc", "markdown" },
    keys = {
      { "<leader>Of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Open file" },
      { "<leader>Oo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian App" },
      { "<leader>O/", "<cmd>ObsidianSearch<cr>", desc = "Search" },
      { "<leader>On", ":ObsidianNew ", mode = "n", desc = "Create New Obsidian Note" },
    },
    opts = {
      workspaces = {
        {
          name = "My Vault",
          path = "~/obsidian/vault",
        },
      },
    },
    -- config = function()
    --   require("obsidian").setup({
    --
    --     dir = "/home/khadd/obsidian/vault",
    --     note_id_func = function(title)
    --       return title
    --     end,
    --     completion = {
    --       nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
    --     },
    --   })
    -- end,
  },
}
