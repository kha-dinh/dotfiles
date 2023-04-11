return {
  {
    "epwalsh/obsidian.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>Of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Open file" },
      {
        "gf",
        function()
          if require("obsidian").util.cursor_on_markdown_link() then
            return "<cmd>ObsidianFollowLink<CR>"
          else
            return "gf"
          end
        end,
        desc = "Follow link",
        mode = "n",
        noremap = false,
        expr = true,
      },
      { "<leader>Oo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian App" },
      { "<leader>O/", "<cmd>ObsidianSearch<cr>", desc = "Search" },
      -- { "<leader><cr>", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
    },
    config = function()
      require("obsidian").setup({

        dir = "/home/khadd/drive/DriveSyncFiles/ObsidianNotes/Brain Dump",
        note_id_func = function(title)
          return title
        end,

        completion = {
          nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
        },
      })
    end,
  },
}
