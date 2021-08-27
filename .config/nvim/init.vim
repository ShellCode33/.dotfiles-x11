set nocompatible
set termguicolors
set relativenumber

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin(data_dir . '/plugged')

" Syntax highlighting plugin
Plug 'sheerun/vim-polyglot'

" Completion plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Theme plugin
Plug 'morhetz/gruvbox'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

if !empty(glob(data_dir . '/plugged/gruvbox'))
    let g:gruvbox_italic = 1
    colorscheme gruvbox
endif

if !empty(glob(data_dir . '/plugged/coc.nvim'))
    source ~/.config/nvim/coc.vim
endif

