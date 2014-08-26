set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tpope/vim-sensible'
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'wincent/Command-T'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-git'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'garbas/vim-snipmate'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'othree/html5.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'rodjek/vim-puppet'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'klen/python-mode'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-liquid'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mv/mv-vim-nginx'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'chriskempson/base16-vim'
Plugin 'zenorocha/dracula-theme'
Plugin 'daylerees/colour-schemes', {'rtp': 'vim-themes/'}

call vundle#end()
filetype plugin indent on

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

" Better syntastic symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" Disable download and install all necessary go binaries from vim-go plugin
let g:go_disable_autoinstall = 1

" Disable auto go fmt on save
let g:go_fmt_autosave = 0

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
