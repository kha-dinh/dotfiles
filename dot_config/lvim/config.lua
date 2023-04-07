require('plugins')
require('base.defaults')
require('base.visual')
require('base.lsp')
require('base.mappings')

-- Language-specific configs
--
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
}
require('languages.rust')
require('languages.tex')
require('languages.cxx')

