return {
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },

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
