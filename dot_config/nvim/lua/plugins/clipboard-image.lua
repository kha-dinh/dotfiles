-- return {
--   {
--     "postfen/clipboard-image.nvim",
--     config = function()
--       require("clipboard-image").setup({
--         -- Default configuration for all filetype
--         default = {
--           img_dir = "images",
--           img_name = function()
--             return os.date("%Y-%m-%d-%H-%M-%S")
--           end, -- Example result: "2021-04-13-10-04-18"
--           affix = "![](%s)", -- Multi lines affix
--         },
--       })
--     end,
--   },
-- }
return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    -- add options here
    -- or leave it empty to use the default settings
  },
  -- keys = {
  --   -- suggested keymap
  --   { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  -- },
  --
}
