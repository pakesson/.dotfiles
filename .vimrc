set nocompatible	" Use full features (Vim mode instead of Vi)

call pathogen#infect()

filetype plugin on

" tabs and indentation
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" configure tabs for various file types
autocmd BufRead,BufNewFile Makefile* setlocal noexpandtab
autocmd Filetype c setlocal tabstop=8 shiftwidth=4 noexpandtab

set autoindent      " Indent same level as the previous line
set smartindent

" GUI options
set guioptions-=T       " Toolbar off
set guioptions-=L       " No left hand scrollbars

" Appearance
set t_Co=256        " Use 256 colors
colorscheme zenburn

syntax on			" syntax highlight
set number			" line numbers
set cursorline		" highlight current line
hi CursorLine term=none cterm=none " disable underline
set showcmd			" Show (partial) command in status line
set ruler			" show the cursor position all the time
set showmode
set laststatus=2
set wildmenu
set guioptions-=m   " Remove menu bar
set guioptions-=T   " Remove toolbar

set scrolloff=3     " Number of lines to keep above and below cursor when scrolling
set showmatch       " Show matching brackets/paranthesis

set backspace=indent,eol,start " allow backspacing over everything in insert mode

" Show tabs and trailing spaces with ':set list' and hide with 'nolist'
set listchars=tab:»·,trail:·

" Search
set incsearch	    " Do incremental searching
set hlsearch        " Hilight search terms
set wrapscan        " When search reaches end of file, go to the beginning.
set ignorecase      " Ignore case in search patterns.  
                    " For shorthand, use :set ic and :set noic
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.

set tags=./tags;/   " Look for tags in current dir and work up to / if not found

set mouse=a         " Enable the use of the mouse.

" Remaps
let mapleader = ","
nnoremap <C-c> :BD<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F8> :!ctags -R .<CR>

