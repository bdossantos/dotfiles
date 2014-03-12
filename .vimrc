set nocompatible
filetype off

" Vundle - Vim Plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'wincent/Command-T'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-git'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'othree/html5.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'rodjek/vim-puppet'
Bundle 'klen/python-mode'
Bundle 'Blackrush/vim-gocode'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-liquid'
Bundle 'kchmck/vim-coffee-script'
Bundle 'mv/mv-vim-nginx'
Bundle 'scrooloose/syntastic'
Bundle 'bling/vim-airline'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'chriskempson/base16-vim'
Bundle 'zenorocha/dracula-theme'
Bundle 'daylerees/colour-schemes', {'rtp': 'vim-themes/'}

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

set ignorecase                    " Ignore case when searching
set smartcase                     " When searching try to be smart about cases
set hlsearch                      " Highlight search results
set incsearch                     " Makes search act like in modern browsers

set guifont=SourceCodePro-Regular:h14
set antialias

syntax enable

set background=dark
colorscheme base16-tomorrow

if exists('+colorcolumn')
  set colorcolumn=80
endif

" always show the status line
set laststatus=2

" enable airline/fugitive integration
let g:airline_enable_branch=1
let g:airline_branch_prefix=1

" enable airline/syntastic integration
let g:airline_enable_syntastic=1

" airline theme
let g:airline_theme='dark'

" Use rubocop with the default ruby checker (mri)
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

" Python
autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4

" Git commit
autocmd Filetype gitcommit setlocal spell textwidth=72

" Autopen NERDTree and focus cursor in new document
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd VimEnter * wincmd p

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Key Bindings
map <F2> :NERDTreeToggle<CR>

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

" More natural split opening
set splitbelow
set splitright

" Store swap files in fixed location, not current directory.
"
" The '//' at the end ensure the swap file name will be built from the complete
" path to the file with all path separators substituted to percent '%' signs.
"
" This will ensure file name uniqueness in the preserve directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
