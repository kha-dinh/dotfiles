return {
  {
    "michaelb/sniprun",
    run = "bash ./install.sh",
    config = function()
      local opts = {
        live_mode_toggle = "enable",
      }
      require("sniprun").setup(opts)
    end,
  },
}
