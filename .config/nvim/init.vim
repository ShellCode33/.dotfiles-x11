" Must have definitions for this init.vim to work
set nocompatible
set termguicolors

" vim directory where data (autoload, plugins, etc.) are located
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
call plug#end()

if !empty(glob(data_dir . '/plugged/gruvbox'))
    let g:gruvbox_italic = 1
    colorscheme gruvbox
endif

if !empty(glob(data_dir . '/plugged/coc.nvim'))
    source ~/.config/nvim/coc.vim

    if !executable('ccls')
        echo "Don't forget to install ccls !"
    endif
endif

function! Handle_Template()
    silent! 0r ~/.config/nvim/templates/%:e
endfunction

if has("autocmd")
    augroup templates
        autocmd BufNewFile * call Handle_Template()
    augroup END
endif

" Personal tastes
set relativenumber
set tabstop=4 shiftwidth=4 expandtab
