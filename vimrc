set nocompatible
filetype off

" Vundle - Vim Plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'rodjek/vim-puppet'
Bundle 'klen/python-mode'
Bundle 'tpope/vim-markdown'
Bundle 'mv/mv-vim-nginx'
Bundle 'daylerees/colour-schemes', { 'rtp': 'vim-themes/' }

" Settings
set encoding=utf-8
filetype plugin indent on         " load file type plugins + indentation

set nowrap                        " don't wrap lines
set tabstop=2 shiftwidth=2        " a tab is two spaces (or set this to 4)
set expandtab                     " use spaces, not tabs (optional)
set smarttab 
set backspace=indent,eol,start    " backspace through everything in insert mode
set autoindent                    " match indentation of previous line

set hidden                        " Handle multiple buffers better.
set title                         " Set the terminal's title
set number                        " Show line numbers.
set ruler                         " Show cursor position.
set cursorline                    " Highlight current line
set wildmode=list:longest         " Complete files like a shell.
set wildmenu                      " Enhanced command line completion.
set novisualbell
set noerrorbells
set history=1000                  " Store lots of :cmdline history

set guifont=SourceCodePro-Regular:h14
set antialias

syntax enable
colorscheme Frontier

" Python
autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4

" Git commit
autocmd Filetype gitcommit setlocal spell textwidth=72

" Autopen NERDTree and focus cursor in new document
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd VimEnter * wincmd p

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Key Bindings
map <F2> :NERDTreeToggle<CR>

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
