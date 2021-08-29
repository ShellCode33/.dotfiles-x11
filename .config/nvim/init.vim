" Must have definitions for this init.vim to work
set nocompatible
set termguicolors
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set noshowmode " hide -- INSERT -- from the command line as we have it in the statusline

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

" Custom powerline
function! StatuslineGit()
  let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  return strlen(l:branchname) > 0 ? l:branchname : ''
endfunction

set statusline=

" Mode we're in
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='R')?'\ \ REPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}

" Buffer index
set statusline+=\ %n\  

" Additional modes
set statusline+=%#DiffAdd#
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}

" Short filename
set statusline+=%#Cursor#
set statusline+=%#CursorLine#
set statusline+=\ %t\  

" Git branch
set statusline+=%#DiffChange#
set statusline+=\ %{StatuslineGit()}\  
set statusline+=%#CursorLine#

" Right corner of the status bar
set statusline+=%=

" File type
set statusline+=%#CursorLine#
set statusline+=\ %y\  

" Total lines count
set statusline+=%#CursorIM#
set statusline+=\ %L\ lines\  

" Current position in the file (percentage)
set statusline+=%#Cursor#
set statusline+=\ %3p%%\  
