return {
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    config = function()
      local opts = {
        live_mode_toggle = "enable",
      }
      require("sniprun").setup(opts)
    end,
  },
  {
    "Vigemus/iron.nvim",
    lazy = false,
    -- config = function()
    -- require("iron.core").setup({})
    -- end,
  },
}
