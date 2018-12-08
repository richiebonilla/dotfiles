" ██╗   ██╗██╗███╗   ███╗
" ██║   ██║██║████╗ ████║
" ██║   ██║██║██╔████╔██║
" ╚██╗ ██╔╝██║██║╚██╔╝██║
"  ╚████╔╝ ██║██║ ╚═╝ ██║
"   ╚═══╝  ╚═╝╚═╝     ╚═╝

set nocompatible
filetype plugin on

call plug#begin()
" Quicker Coding
Plug 'valloric/MatchTagAlways'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vitorgalvao/autoswap_mac'
Plug 'nixon/vim-vmath'
"Linting & Formatting
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'
" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
" Auto Completion & Intellisense
Plug 'mattn/emmet-vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'alvan/vim-closetag'
Plug 'SirVer/ultisnips'
Plug 'jiangmiao/auto-pairs'
" Snippets
Plug 'epilande/vim-es2015-snippets'
Plug 'epilande/vim-react-snippets'
" Syntax Highlighting
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'ap/vim-css-color'
Plug 'fremff/vim-css-syntax'
" Themes & Appearance
Plug 'dracula/vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Safety Net and Looking Backwards
set history=1000
set undofile
set undodir=~/.config/nvim/undo
set undolevels=1000
set undoreload=10000
set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/backup

" Appearance
syntax on
set number
set relativenumber
set termguicolors
set background=dark
colorscheme dracula
hi Normal guibg=grey13
let g:airline_theme='minimalist'
let g:airline_section_y=0
let g:airline#extensions#branch#enabled = 1
set scrolloff=30

" Show tabs and trailing whitespace
set listchars=tab:>~,nbsp:_,trail:•
set list

" Ignore case when searching
set ignorecase

" Tabs vs Spaces Holy War
set expandtab
set tabstop=2
set shiftwidth=2

" Allow vim-jsx to highlight jsx outside of .jsx files
let g:jsx_ext_required = 0

" Allow MatchTagAlways to highlight JSX
let g:mta_filetypes = {
  \ 'javascript.jsx' : 1,
  \}

" Fix files with prettier, and then ESLint
let g:ale_fixers = ['prettier', 'eslint']
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1

" Configure ale to lint jsx files
augroup FiletypeGroup
  autocmd!
  au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

let g:ale_linter_aliases= {'jsx': ['css', 'javascript']}
let g:ale_linters = {'jsx': ['eslint']}

" Set NERDTree trigger key
" map <C-n> :NERDTreeToggle<CR>

" Close NERDTree when file is selected
let NERDTreeQuitOnOpen = 1

" Open Split Below and Vertical Split on Right
set splitbelow splitright

" Remap leader key
let mapleader = ","

" Map ; to : for easier commands
nnoremap ; :

" Leader Key Mappings
map <leader>a :qa<Enter>
nnoremap <leader>b :buffers<CR>:buffer<Space>
map <leader>f :Files<Enter>
map <leader>n :NERDTreeToggle<Enter>
map <leader>q :q<Enter>
nnoremap <leader>s :sp<CR>
nnoremap <leader>v :vsp<CR>
" set splitbelow splitright made this line superfluous
"nnoremap <leader>v :buffers<CR>:vert belowright sb<Space>
map <leader>w :w<Enter>
map <leader>W :wq<Enter>
map <leader>x :x<Enter>
map <leader>! :q!<Enter>
map <leader><Space> :bn<Enter>

" Pane Navigation
map <leader>j <C-W>j
map <leader>k <C-W>k
map <leader>h <C-W>h
map <leader>l <C-W>l

" Move key mappings
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Add New Line Below w/out Entering Insert Mode
nmap <CR> o<Esc>

" Run command to clear highlighting everytime Esc is hit
nmap <Esc> <Esc>:noh<CR>
nmap <C-c> <Esc>:noh<CR>

" Another option for Esc when working on laptop keeb
inoremap jj <Esc>

" Emmet Trigger Key Remap
let g:user_emmet_leader_key = '<C-a>'

" Code Folding
set foldmethod=indent
set foldlevelstart=2

" YouCompleteMe
" Start autocompletion after 3 chars
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_min_num_identifier_candidate_chars = 3
let g:ycm_enable_diagnostic_highlighting = 0
" Don't show YCM's preview window
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', $HOME.'/.config/UltiSnips']
" Location of my custom snippets
let g:UltiSnipsSnippetsDir=$HOME."/.config/UltiSnips"

" Quickly Edit/Source Vimrc
nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC<CR>

" Delete all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Replace special characters with html equivalent
autocmd FileType html inoremap &<space> &amp;<space>
autocmd FileType html inoremap •<space> &bull;<space>

" VMath Keybindings
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++
