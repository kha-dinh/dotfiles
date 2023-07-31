local base00 = "#161616"
local base06 = "#ffffff"
local base09 = "#78a9ff"
local oxocarbon = {
  base00 = base00,
  base06 = base06,
  base07 = "#08bdba",
  base08 = "#3ddbd9",
  base09 = base09,
  base10 = "#ee5396",
  base11 = "#33b1ff",
  base12 = "#ff7eb6",
  base13 = "#42be65",
  base14 = "#be95ff",
  base15 = "#82cfff",
  blend = "#131313",
  none = "NONE",
}

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      local catppuccin = require("catppuccin.palettes.mocha")
      require("catppuccin").setup({
        flavour = "mocha",
        color_overrides = {
          all = {
            pink = oxocarbon.base07,     -- #define
            yellow = oxocarbon.base09,   -- keywords
            lavender = oxocarbon.base10, -- fields
            sky = oxocarbon.base07,      -- operators/TODO
            blue = oxocarbon.base12,     -- function name
            -- green = oxocarbon.base13, -- strings
            mauve = oxocarbon.base14,    -- macro names, "struct", "include"
            -- green = oxocarbon.base15,    -- strings
            green = oxocarbon.base13,    -- strings
            -- green = catppuccin.green, -- strings
            peach = oxocarbon.base15,    -- numbers
            maroon = catppuccin.yellow,  -- parameters
            -- green = catppuccin.yellow, -- strings
            -- maroon = oxocarbon.base12, -- parameters
            -- base = "#212121",
            base = oxocarbon.base00,
            -- overlay0 = oxocarbon.base13, -- comment
          },
        },
      })
    end,
  },
  { "nyoom-engineering/oxocarbon.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "oxocarbon",
      -- colorscheme = "tokyonight-night",
    },
  },
}
