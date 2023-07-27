return {
  {
    -- Display image within terminal, useful for markdown notes
    event = "VeryLazy",
    "edluffy/hologram.nvim",
    config = function()
      require("hologram").setup({
        auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
      })
    end,
  },
}
