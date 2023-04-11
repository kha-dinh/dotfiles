return {
  "echasnovski/mini.animate",
  event = "VeryLazy",
  opts = function(opts)
    -- don't use animate when scrolling with the mouse
    -- local mouse_scrolled = false
    -- for _, scroll in ipairs({ "Up", "Down" }) do
    --   local key = "<ScrollWheel" .. scroll .. ">"
    --   vim.keymap.set({ "", "i" }, key, function()
    --     mouse_scrolled = true
    --     return key
    --   end, { expr = true })
    -- end
    --
    -- return {
    --   resize = {
    --     timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
    --   },
    --   scroll = {
    --     timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
    --     subscroll = animate.gen_subscroll.equal({
    --       predicate = function(total_scroll)
    --         if mouse_scrolled then
    --           mouse_scrolled = false
    --           return false
    --         end
    --         return total_scroll > 1
    --       end,
    --     }),
    --   },
    -- }
    local animate = require("mini.animate")
    opts.resize.timing = animate.gen_timing.linear({ duration = 50, unit = "total" })
    opts.scroll.timing = animate.gen_timing.linear({ duration = 50, unit = "total" })
  end,
  -- config = function(_, opts)
  --   require("mini.animate").setup(opts)
  -- end,

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, { "filetype" })
    end,
  },
}
