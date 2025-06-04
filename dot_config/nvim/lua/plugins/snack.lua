return {
  {

    "folke/snacks.nvim",
    ---@type snacks.Config

    keys = {
      { "<leader>K", require("snacks").image.hover, desc = "Display hover image" },
    },
    opts = {
      image = {
        enabled = false,
        inline = false,
        float = true,
        -- your image configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    },
  },
}
