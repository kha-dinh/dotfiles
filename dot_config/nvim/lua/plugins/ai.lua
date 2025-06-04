return {
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        -- Change the default chat adapter
        chat = {
          adapter = "qwen",
          inline = "qwen",
        },
        inline = {
          adapter = "gwen",
        },
        cmd = {
          adapter = "gwen",
        },
      },
      adapters = {
        qwen = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "qwen", -- Give this adapter a different name to differentiate it from the default ollama adapter
            schema = {
              model = {
                default = "qwen3:0.6b",
              },
            },
          })
        end,
      },
      opts = {
        log_level = "DEBUG",
      },
      display = {
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "default", -- default|mini_diff
        },
      },
    },
  },
}
