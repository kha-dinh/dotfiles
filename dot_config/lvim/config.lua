require('plugins')
require('base.defaults')
require('base.visual')
require('base.lsp')
require('base.mappings')

-- Language-specific configs
require('languages.rust')
require('languages.tex')
require('languages.cxx')

lvim.lsp.templates_dir = join_paths(get_runtime_dir(), "after", "ftplugin")
