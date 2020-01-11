set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'markcornick/vim-bats'
Plugin 'tpope/vim-sensible'
Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-git'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'hashivim/vim-hashicorp-tools'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'w0rp/ale'
Plugin 'sheerun/vim-polyglot'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'chriskempson/base16-vim'

call vundle#end()
filetype plugin indent on         " load file type plugins + indentation

" Settings
set autoindent                    " match indentation of previous line
set autowrite                     " Automatically :write before running commands
set backspace=indent,eol,start    " backspace through everything in insert mode
set clipboard=unnamed             " For OSX clipboard
set cursorline                    " Highlight current line
set encoding=utf-8
set expandtab                     " use spaces, not tabs (optional)
set foldenable                    " Enable folding
set foldlevelstart=10             " Open most folds by default
set foldmethod=indent             " Fold based on indent level
set foldnestmax=10                " 10 nested fold max
set hidden                        " Handle multiple buffers better.
set history=1000                  " Store lots of :cmdline history
set hlsearch                      " Highlight search results
set ignorecase                    " Ignore case when searching
set incsearch                     " Makes search act like in modern browsers
set laststatus=2                  " Always display the status line
set lazyredraw                    " Redraw only when we need to.
set noerrorbells
set novisualbell
set nowrap                        " don't wrap lines
set number                        " Show line numbers.
set numberwidth=5                 " Width of the "gutter" column used for numbering
set relativenumber                " Relative line numbers.
set ruler                         " Show cursor position.
set showcmd                       " Show command in bottom bar
set showmatch                     " Highlight matching [{()}]
set smartcase                     " When searching try to be smart about cases
set smarttab
set spelllang=en                  " Check all regions of English.
set tabstop=2 shiftwidth=2        " a tab is two spaces (or set this to 4)
set ttimeout                      " Fast VIM
set ttimeoutlen=100
set ttyfast                       " Ensure ttyfast is enabled
set undodir=~/.vimundo            " Do not add ~un files everywhere I go
set undofile                      " Persistent undo
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

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

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

if exists('+colorcolumn')
  set colorcolumn=80
endif

" Disable modelines for security reasons
set modelines=0
set nomodeline

" always show the status line
set laststatus=2

" Update sign column every quarter second
set updatetime=250

" airline/tmuxline integration
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0

" airline/powerline font interation
let g:airline_powerline_fonts=1

" enable airline/fugitive integration
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch_prefix#enabled=1

" enable airline/syntastic integration
let g:airline#extensions#ale#enabled=1

" airline theme
let g:airline_theme='base16_ashes'

" Use rubocop with the default ruby checker (mri)
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

" file fixer
let g:ale_fixers = {
\  'css': ['prettier'],
\  'javascript': ['prettier', 'eslint'],
\  'json': ['prettier'],
\  'sh': ['shfmt'],
\  'typescript': ['prettier', 'eslint', 'tslint'],
\  'yaml': ['prettier'],
\}

" keep the sign gutter open
let g:ale_sign_column_always = 1

" Better syntastic symbols
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" fix files when you save them.
let g:ale_fix_on_save = 1

" Disable download and install all necessary go binaries from vim-go plugin
let g:go_disable_autoinstall = 1

" Disable go version warning
let g:go_version_warning = 0

" Disable auto go fmt on save
let g:go_fmt_autosave = 0

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Ensure that this plugin works well with Tim Pope's fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

" Limeligth + Goyo integration
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!

" hashivim
let g:terraform_fmt_on_save=1

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

" Automatically source the .vimrc file after editing
augroup autosourcing
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

" Key Bindings
let mapleader = ','             " leader is comma
inoremap jj <ESC>

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Search with ack / ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
" :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

nnoremap <Leader>a :Ag!<Space>
nnoremap <Leader>A :Ack<Space>

" Open fzf
nnoremap <silent> <leader>f :FZF<CR>

" Open tig
nmap <leader>t :execute ":Silent !tig ".GetSmartWd()<CR><CR>

" Ale fix
nmap <leader>s :ALEFix<CR>
nmap <leader>se :let g:ale_fix_on_save=1<CR>
nmap <leader>sd :let g:ale_fix_on_save=0<CR>

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
