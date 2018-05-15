
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'wincent/terminus'
Plug 'ervandew/supertab'
"Plug 'jiangmiao/auto-pairs'
Plug 'tenfyzhong/CompleteParameter.vim'

" Rust
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'make release',
    \ }
Plug 'sebastianmarkow/deoplete-rust'
Plug 'rust-lang/rust.vim'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

" Autocomplete plugin
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'Shougo/neosnippet.vim'
"Plug 'Shougo/neosnippet-snippets'
"Plug 'Shougo/echodoc.vim'

" Linter
Plug 'w0rp/ale'

" Color themes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'

" Airline theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()




" Activating color theme
set background=dark     " Setting dark mode
"set background=light   " Setting light mode
set termguicolors 		" This is needed for quit some recent theme nowadays
let g:gruvbox_contrast_dark = 'medium' "Possible values: soft, medium and hard
colorscheme onedark
colorscheme gruvbox

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='deus'
let g:airline_theme='bubblegum'




" Common settings
set tabstop=4     " a tab is four spaces
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=10000 " remember more commands and search history
set undolevels=1000 " use many muchos levels of undo
set title         " change the terminal's title
set mouse=a
let mapleader="<"   " change leader key from '\' to '<'
set timeout timeoutlen=2000
set showcmd       " Show (partial) command in status line.
set noshowmode    " get rid of -- INSERT --
set hidden        " Hide buffers when they are abandoned
set expandtab     " Uses space instead of tabs
"set wildmenu
"set wildmode=longest,list:full


set backup
set backupdir=$HOME/.vim.backup

if !has('gui_running')
      set t_Co=256
endif



" NERDTree config
nmap <F7> :NERDTreeToggle<CR>
" Auto close NERDTree when left alone
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | eno

" Tagbar settings
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits',
        \'i:impls,trait implementations',
    \]
    \}

" LanguageClient-neovim settings
autocmd BufReadPost *.rs setlocal filetype=rust

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Toggle the lint panel
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
" And map it
nnoremap <F3> : <C-u> QFix <CR>

" Switch back and forth from panel to panel
nnoremap <Tab> <c-w>w

" Use deoplete.
let g:python_host_prog  = '/opt/usr/anaconda3/envs/py27/bin/python2'
let g:python3_host_prog = '/opt/usr/anaconda3/envs/maelstrom/bin/python3'
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#rust#show_duplicates = 1
"let g:deoplete#sources#rust#disable_keymap=1
"let g:deoplete#sources#rust#documentation_max_height=75
"nmap <buffer> K <plug>DeopleteRustShowDocumentation
nmap <buffer> <m-q> <plug>DeopleteRustShowDocumentation

"let g:deoplete#sources.rust = ['LanguageClient']
let g:deoplete#sources#rust#racer_binary='/home/home/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/home/.multirust/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#mappings#manual_complete()
        function! s:check_back_space() abort "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}


" CompleteParameter settings
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <m-;> <Plug>(complete_parameter#goto_next_parameter)
imap <m-;> <Plug>(complete_parameter#goto_next_parameter)

smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
smap <m-,> <Plug>(complete_parameter#goto_previous_parameter)
imap <m-,> <Plug>(complete_parameter#goto_previous_parameter)

" ALE setting
" Enable completion where available.
"let g:ale_completion_enabled = 1 		" This is buggy with deoplete/LanguageClient-neovim
let g:ale_linters = {'rust': ['rls']}
let g:airline#extensions#ale#enabled = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
"let g:ale_open_list = 1
"let g:ale_set_highlights = 0
"let g:ale_sign_column_always = 0
let g:ale_sign_info = 'ℹ'
let g:ale_sign_warning = '⚠'
let g:ale_sign_error = '✖'
"let g:ale_open_list = 1
" Let's disable ALE's linting by default
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0


" EchoDoc
"let g:echodoc_enable_at_startup = 1
