return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>tt",
        "<cmd>Telescope<cr>",
        desc = "Open Telescope",
      },
      {
        "<leader>tm",
        "<cmd>Telescope man_pages<cr>",
        desc = "Find manual pages",
      },
    },
    opts = function()
      require("telescope").load_extension("projects")
    end,
  },
}
