set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'markcornick/vim-bats'
Plugin 'tpope/vim-sensible'
Plugin 'rking/ag.vim'
Plugin 'junegunn/fzf'
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
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'edkolev/tmuxline.vim'

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
set relativenumber                " Relative line numbers.
set number                        " Show line numbers.
set numberwidth=5                 " Width of the "gutter" column used for numbering
set ruler                         " Show cursor position.
set cursorline                    " Highlight current line
set showcmd                       " Show command in bottom bar
set wildmode=list:longest         " Complete files like a shell.
set wildmenu                      " Enhanced command line completion.
set lazyredraw                    " Redraw only when we need to.
set novisualbell
set noerrorbells
set history=1000                  " Store lots of :cmdline history

set ignorecase                    " Ignore case when searching
set smartcase                     " When searching try to be smart about cases
set hlsearch                      " Highlight search results
set incsearch                     " Makes search act like in modern browsers
set showmatch                     " Highlight matching [{()}]
set laststatus=2                  " Always display the status line
set autowrite                     " Automatically :write before running commands

set foldenable                    " Enable folding
set foldlevelstart=10             " Open most folds by default
set foldnestmax=10                " 10 nested fold max
set foldmethod=indent             " Fold based on indent level

set undofile                      " Persistent undo
set undodir=~/.vimundo            " Do not add ~un files everywhere I go

" Set the terminal's title
if &term == 'screen'
  set t_ts=k
  set t_fs=\
elseif &term == 'screen' || &term == 'xterm'
  set title
endif

set guifont=Hack:h14
set antialias

syntax enable

set background=dark
let base16colorspace=256
colorscheme base16-tomorrow

if exists('+colorcolumn')
  set colorcolumn=80
endif

" always show the status line
set laststatus=2

" airline/tmuxline integration
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0

" set airline theme
let g:airline_theme='base16'

" airline/powerline font interation
let g:airline_powerline_fonts=1

" enable airline/fugitive integration
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch_prefix#enabled=1

" enable airline/syntastic integration
let g:airline#extensions#syntastic#enabled=1

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

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Limeligth + Goyo integration
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!

" Line number
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  " https://github.com/thoughtbot/dotfiles/blob/master/vimrc#L34-L40
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Python
  autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4

  " Git commit
  autocmd Filetype gitcommit setlocal spell textwidth=72

  " Enable spellchecking for Markdown
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd FileType markdown setlocal spell

  " Crontab http://calebthompson.io/crontab-and-vim-sitting-in-a-tree/
  autocmd filetype crontab setlocal nobackup nowritebackup

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Let's tell Vim to automatically use absolute line numbers when we're in
  " insert mode and relative numbers when we're in normal mode
  autocmd InsertEnter * :set number
  autocmd InsertLeave * :set relativenumber
augroup END

" Key Bindings
let mapleader = ','             " leader is comma
inoremap jj <ESC>

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Open ag.vim
nnoremap <leader>a :Ag

" Open fzf
nnoremap <silent> <leader>f :FZF<CR>

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
