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
    default = {
      -- file and directory options
      dir_path = "images", ---@type string | fun(): string
      extension = "png", ---@type string | fun(): string
      file_name = "%Y-%m-%d-%H-%M-%S", ---@type string | fun(): string
      -- use_absolute_path = false, ---@type boolean | fun(): boolean
      relative_to_current_file = true, ---@type boolean | fun(): boolean
      --
      -- -- template options
      -- template = "$FILE_PATH", ---@type string | fun(context: table): string
      -- url_encode_path = false, ---@type boolean | fun(): boolean
      -- relative_template_path = true, ---@type boolean | fun(): boolean
      -- use_cursor_in_template = true, ---@type boolean | fun(): boolean
      -- insert_mode_after_paste = true, ---@type boolean | fun(): boolean
      --
      -- -- prompt options
      -- prompt_for_file_name = true, ---@type boolean | fun(): boolean
      -- show_dir_path_in_prompt = false, ---@type boolean | fun(): boolean
      --
      -- -- base64 options
      -- max_base64_size = 10, ---@type number | fun(): number
      -- embed_image_as_base64 = false, ---@type boolean | fun(): boolean
      --
      -- -- image options
      -- process_cmd = "", ---@type string | fun(): string
      -- copy_images = false, ---@type boolean | fun(): boolean
      -- download_images = true, ---@type boolean | fun(): boolean
      --
      -- -- drag and drop options
      -- drag_and_drop = {
      --   enabled = true, ---@type boolean | fun(): boolean
      --   insert_mode = false, ---@type boolean | fun(): boolean
      -- },
    },

    -- filetype specific options

    -- file, directory, and custom triggered options
    files = {}, ---@type table | fun(): table
    dirs = {}, ---@type table | fun(): table
    custom = {}, ---@type table | fun(): table
    -- add options here
    -- or leave it empty to use the default settings
  },
  -- keys = {
  --   -- suggested keymap
  --   { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  -- },
  --
}
