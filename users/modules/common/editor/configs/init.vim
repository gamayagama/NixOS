let mapleader=' '
set background=dark
colorscheme gruvbox8

" Functional
set encoding=utf-8
set fileencoding=utf-8
set mouse=a
set splitbelow
set splitright
set clipboard+=unnamedplus

" Search settings
set incsearch
set ignorecase
set smartcase

" Disable ex-mode
nnoremap Q <Nop>
nnoremap gQ <Nop>

" Visual
set noshowmode
set linebreak " Prevent new line inside of a word when wrapping
set showmatch " Show matching brackets
set cursorline " Highlight current line
set nu rnu " Set relative line number + current line number
syntax on
" set termguicolors
" hi Normal guibg=NONE ctermbg=NONE

set cmdheight=1
set pumheight=10
set backspace=2
set laststatus=2
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=0
set numberwidth=1
