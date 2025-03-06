function _G.get_oil_winbar()
  local dir = require("oil").get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

local detail = false
return {
  {
    "stevearc/oil.nvim",
    -- event = "VeryLazy",
    opts = {
      win_options = {
        winbar = "%!v:lua.get_oil_winbar()",
      },
      keymaps = {
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
            else
              require("oil").set_columns({ "icon" })
            end
          end,
        },
        ["?"] = { "actions.show_help", mode = "n" },
        ["H"] = { "actions.toggle_hidden", mode = "n" },
        ["q"] = { "actions.close", mode = "n" },
      },
    },
    keys = {
      {
        "-",
        "<cmd>Oil<cr>",
        mode = "n",
        desc = "Open Oil explorer",
      },
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
}
