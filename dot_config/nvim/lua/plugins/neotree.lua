return {

  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<C-e>", "<cmd>Neotree focus<cr>", desc = "Focus NeoTree" },
    },
    dependencies = {
      "s1n7ax/nvim-window-picker",
    },
    opts = {
      window = {
        mappings = {
          ["<cr>"] = "open_with_window_picker",
          ["o"] = "system_open",
        },
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          -- macOs: open file in default application in the background.
          -- Probably you need to adapt the Linux recipe for manage path with spaces. I don't have a mac to try.
          vim.api.nvim_command("silent !open -g " .. path)
          -- Linux: open file in default application
          vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
        end,
      },
    },
  },
}
