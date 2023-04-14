local Util = require("lazyvim.util")

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = function(opts)
      local wk = require("which-key")
      opts.plugins = { spelling = true }
      local keymaps = {
        ["<leader>t"] = { name = "+telescope" },
      }
      if Util.has("overseer") then
        keymaps["<leader>o"] = { name = "+overseer" }
      end
      wk.register(keymaps)
    end,
  },
}
