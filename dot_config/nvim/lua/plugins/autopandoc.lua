return {
  {
    "jghauser/auto-pandoc.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "markdown",
    keys = {
      {
        "go",
        function()
          require("auto-pandoc").run_pandoc()
        end,
        desc = "Auto pandoc",
      },
    },
  },
}
