" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Themes
Plug 'junegunn/seoul256.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'morhetz/gruvbox'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set termguicolors

let g:seoul256_background = 233

let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1

let g:gruvbox_italic = 1

colorscheme gruvbox

set relativenumber

" External sources
source ~/.config/nvim/coc.vim
