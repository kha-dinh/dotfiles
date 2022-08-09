set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set clipboard+=unnamedplus    



" Set leader to space
"

map <Space> <leader>
nnoremap <leader>pf :Telescope find_files<CR>

lua require('plugins')
lua require('init')

