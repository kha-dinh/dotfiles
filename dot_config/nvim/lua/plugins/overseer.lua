return {
  {
    "stevearc/overseer.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>oo", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run Overseer Tasks" },
      { "<leader>ol", "<cmd>OverseerLoadBundle<cr>", desc = "Load Overseer Bundle" },
      { "<leader>os", "<cmd>OverseerSaveBundle<cr>", desc = "Save Overseer Bundle" },
      { "<leader>od", "<cmd>OverseerDeleteBundle<cr>", desc = "Save Overseer Bundle" },
    },
    config = function()
      require("overseer").setup()
    end,
  },
}
