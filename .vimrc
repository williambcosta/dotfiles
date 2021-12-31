" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file is use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add line numbers to the file. The line numbers will be relative to the cursor position
set relativenumber

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not wrap lines. Allow long lines to extend as far as the line goes.
"set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Don't show the mode you are on the last line.
set noshowmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Always show the status bar.
set laststatus=2

" Show white spaces
set list

" Change the list of hidden caracters for end of line, multispace, tabs and trail space
set lcs=eol:¶,multispace:·,tab:»\ ,trail:·

" PLUGINS {{{
" To install the plugins type :PlugInstall
call plug#begin('~/.vim/plugged')

  "Plug 'preservim/nerdtree'
  Plug 'joshdick/onedark.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-surround'

call plug#end()

" }}}

" COLLOR & FONTS {{{

colorscheme onedark

let g:lightline = {
  \ 'colorscheme': 'darcula',
  \ }

"}}}

" MAPPINGS {{{

" Type jj to exit insert mode quickly.
inoremap jj <Esc>

" Map \ in normal mode to de-emphasize last search
nnoremap \ :noh <CR> 

" Press the space bar to type the : character in command mode.
nnoremap <space> :

" Pressing the letter o will open a new line below the current one and O to open a new line above.
" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$

" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" change size of the split views whit ctrl+ some arrow
nnoremap <c-UP> <c-w>+
nnoremap <c-DOWN> <c-w>-
nnoremap <c-LEFT> <c-w><
nnoremap <c-RIGHT> <c-w>>

" Map the F2 key to toggle show whitespaces
nnoremap <F2> :set list!<CR>

" Open file explorer in a new tab
nnoremap <F3> :Texplore<cr>

" Shwo vim's Register
nnoremap <F4> :reg<cr>

" Toggle relative line numbers
nnoremap <F5> :set relativenumber!<cr> :set number!<cr>

" }}}

" VIMSCRIPT {{{

" Enable the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END

" If GUI version of Vim is running set these options.
if has('gui_running')

    " Jump to a tab whit alt+number
    nnoremap <a-1> 1gt
    nnoremap <a-2> 2gt
    nnoremap <a-3> 3gt
    nnoremap <a-4> 4gt
    nnoremap <a-5> 5gt
    nnoremap <a-6> 6gt
    nnoremap <a-7> 7gt
    nnoremap <a-8> 8gt
    nnoremap <a-9> 9gt
    nnoremap <a-0> 10gt

    " Map Ctrl-Backspace to delete the previous word in insert mode.
    imap <C-BS> <C-W>

    " Set a custom font you have installed on your computer.
    " Syntax: <font_name>\ <weight>\ <size>
    set guifont=Monospace\ Regular\ 10

    " Hide the toolbar.
    set guioptions-=T

    " Hide the the left-side scroll bar.
    set guioptions-=L

    " Hide the the left-side scroll bar.
    set guioptions-=r

    " Hide the the menu bar.
    set guioptions-=m

    " Hide the the bottom scroll bar.
    set guioptions-=b

    " Map the F6 key to toggle the menu, toolbar, and scroll bar.
    " <Bar> is the pipe character.
    " <CR> is the enter key.
    nnoremap <F6> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif<CR>

endif

" }}}
