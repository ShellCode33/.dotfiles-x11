" Must have definitions for this init.vim to work
set nocompatible
set termguicolors

" Personal tastes
set number relativenumber
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set noshowmode " hide -- INSERT -- from the command line as we have it in the statusline
set scrolloff=999
set colorcolumn=88

" Set <leader> key to space
let mapleader = " "

" vim directory where data (autoload, plugins, etc.) are located
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" CoC will automatically install those extensions if they're missing
let g:coc_global_extensions = [
\   'coc-json',
\   'coc-pyright',
\   'coc-html',
\   'coc-yaml',
\   'coc-highlight',
\   'coc-clangd',
\ ]

" Plugins will be downloaded under the specified directory.
call plug#begin(data_dir . '/plugged')

    " Syntax highlighting plugin
    Plug 'sheerun/vim-polyglot'

    " Completion plugin
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': { -> coc#util#install() } }

    " Git integration plugin
    Plug 'tpope/vim-fugitive'
    Plug 'rbong/vim-flog'

    " File explorer plugin
    Plug 'preservim/nerdtree'

    " Files finder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Theme plugin
    Plug 'gruvbox-community/gruvbox'

call plug#end()

if !empty(glob(data_dir . '/plugged/gruvbox'))
    let g:gruvbox_italic = 1
    colorscheme gruvbox
endif

if !empty(glob(data_dir . '/plugged/coc.nvim'))
    source ~/.config/nvim/coc.vim
endif

if !empty(glob(data_dir . '/plugged/nerdtree'))
    augroup nerdtree
        autocmd!

        " Start NERDTree when Vim is started without file arguments.
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

    augroup END
endif

function! Handle_Template()
    silent! 0r ~/.config/nvim/templates/%:e
endfunction

augroup templates
    autocmd!
    autocmd BufNewFile * call Handle_Template()
augroup END

" Utility function to get the current git branch for the statusline
function! StatuslineGit()
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    return empty(l:branchname) ? '' : "\ua0" . l:branchname . "\ua0"
endfunction

" Utility function to get function name the cursor is in
function! CocCurrentFunction()
    let l:current_function = get(b:, 'coc_current_function', '')
    return empty(l:current_function) ? '' : "\ua0" . l:current_function . "\ua0"
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

" Filename
set statusline+=%#CursorLine#
set statusline+=\ %F\  

if !empty(glob(data_dir . '/plugged/coc.nvim'))
    set statusline+=%#CursorIM#
    set statusline+=%{CocCurrentFunction()}
endif

" Git branch
set statusline+=%#DiffChange#
set statusline+=%{StatuslineGit()}
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

" Custom remaps
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <expr> <C-f> (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<cr>"

" Undo breakpoints
inoremap , ,<C-g>u
inoremap ? ?<C-g>u
inoremap ! !<C-g>u
inoremap - -<C-g>u
inoremap ; ;<C-g>u
inoremap : :<C-g>u
inoremap ( (<C-g>u
inoremap ) )<C-g>u
inoremap [ [<C-g>u
inoremap ] ]<C-g>u
inoremap { {<C-g>u
inoremap } }<C-g>u

" Moving text
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==i
inoremap <C-k> <esc>:m .-2<CR>==i
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
