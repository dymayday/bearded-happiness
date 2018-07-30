
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
filetype off
call plug#begin()

Plug 'scrooloose/nerdtree'
" Comment helper.
Plug 'scrooloose/nerdcommenter'
Plug 'tomtom/tcomment_vim'

" Ouline viewer
" Plug 'majutsushi/tagbar'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/unite-outline'
" TagBar alternat using CtrlP
Plug 'tacahiroy/ctrlp-funky'

" Auto insert semi colon at the end of Rust file YaY ! =]
Plug 'tpope/vim-repeat'
Plug 'lfilho/cosco.vim'

" Relative line number
Plug 'myusuf3/numbers.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'wincent/terminus'
Plug 'ervandew/supertab'


" LANGUAGE SUPPORT
" Automatically close parenthesis, etc
Plug 'jiangmiao/auto-pairs'

" Color parenthesis and such
Plug 'luochen1990/rainbow'

" Autocomplete plugin
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Completetion manager. New and way better than deoplete
Plug 'ncm2/ncm2'
" ncm2 requires nvim-yarp
Plug 'roxma/nvim-yarp'

" Snippers support
" Track the engine
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. So we need to add this:
Plug 'honza/vim-snippets'
Plug 'ncm2/ncm2-ultisnips'

Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
" Commenting out this one because it create duplicate entry with RLS.
" Plug 'ncm2/ncm2-racer'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-neoinclude' | Plug 'Shougo/neoinclude.vim'
Plug 'ncm2/ncm2-match-highlight'

" Better language packs
Plug 'sheerun/vim-polyglot'

" Rust
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'make release',
    \ }
" Plug 'sebastianmarkow/deoplete-rust'
Plug 'rust-lang/rust.vim'

" Python
" Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
" Just to add the python go-to-definition and similar features, autocompletion
" from this plugin is disabled
Plug 'davidhalter/jedi-vim'

" Linter
Plug 'w0rp/ale'


" Multi-entry selection UI.
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plug 'ctrlpvim/ctrlp.vim'
" This is an extension for the awesome vim CtrlP plugin.
Plug 'fisadev/vim-ctrlp-cmdpalette'


" Some pretty things
" Airline theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color themes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'

" A plugin to color colornames and codes
Plug 'chrisbra/Colorizer'


call plug#end()
filetype on

"let g:gruvbox_improved_strings = 1
"let g:gruvbox_improved_warnings = 1


let base16colorspace=256 " Access colors present in 256 colorspace
" Activating color theme
set background=dark      " Setting dark mode
"set background=light    " Setting light mode
set termguicolors 		 " This is needed for quit some recent theme nowadays
let g:gruvbox_contrast_dark = 'medium' "Possible values: soft, medium and hard
colorscheme onedark
colorscheme gruvbox

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='deus'
"let g:airline_theme='bubblegum'


" Select commands to be executed by default
let g:ctrlp_cmdpalette_execute = 1


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
set scrolloff=1   " Always show at least one line above/below the cursor
"set wildmenu
"set wildmode=longest,list:full

" Copy to clipboard
nnoremap  <leader>y  "+y
vnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p  "+p
vnoremap <leader>p  "+p

" Auto insert semicolon using cosco
let g:cosco_ignore_comment_lines = 1     " Default : 0
"let g:auto_comma_or_semicolon = 1        " Default : 0, way too experimental
let g:cosco_filetype_whitelist = ['rust']
autocmd FileType rust nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon)
autocmd FileType rust imap <silent> <Leader>; <c-o><Plug>(cosco-commaOrSemiColon)
autocmd FileType rust imap <silent> <Leader>o <c-o><Plug>(cosco-commaOrSemiColon)<ESC>o
autocmd FileType rust nmap <silent> <Leader>o <Plug>(cosco-commaOrSemiColon)<ESC>o

set backup
set backupdir=$HOME/.vim.backup

if !has('gui_running')
      set t_Co=256
endif

" numbers.vim settings - Toggle relative line numbering
nnoremap <F9> :NumbersToggle<CR>
let g:enable_numbers = 0


" ctags configuration
" autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
" autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" TagBar setup
" nmap <F8> :TagbarToggle<CR>
" let g:tagbar_type_rust = {
"     \ 'ctagstype' : 'rust',
"     \ 'kinds' : [
"         \'T:types,type definitions',
"         \'f:functions,function definitions',
"         \'g:enum,enumeration names',
"         \'s:structure names',
"         \'m:modules,module names',
"         \'c:consts,static constants',
"         \'t:traits',
"         \'i:impls,trait implementations',
"         \]
"     \}


" ctrlp-funky is a TagBar alternat using CtrlP
let g:ctrlp_funky_syntax_highlight = 1
" This allows you to switch to no-limit mode.
let g:ctrlp_funky_nolim = 1
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>



" NERDTree config
nmap <F7> :NERDTreeToggle<CR>
" Auto close NERDTree when left alone
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | en

" Rainbow parenthesis toggle.
nmap <F6> :RainbowToggle<CR>

" Auto-Pairs settings.
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'



" LanguageClient-neovim settings
autocmd BufReadPost *.rs setlocal filetype=rust
" Disable linting for python files.
autocmd FileType python let g:LanguageClient_diagnosticsEnable=0

" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_selectionUI = "fzf"

" call deoplete#custom#source(
"             \ 'LanguageClient',
"             \ 'min_pattern_length',
"             \ 1)

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['/home/home/junk/anaconda/envs/maelstrom/bin/pyls'],
    \ }
"let g:deoplete#sources.rust = ['LanguageClient']
" let g:deoplete#sources#rust#racer_binary='/home/home/.cargo/bin/racer'
" let g:deoplete#sources#rust#rust_source_path='/home/home/.multirust/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
" "let g:deoplete#sources#rust#disable_keymap=1
" "let g:deoplete#sources#rust#documentation_max_height=75
" let g:deoplete#sources#rust#show_duplicates = 0
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Completion manager settings.
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" ncm2-match-highlight config.
let g:ncm2#match_highlight = 'bold'
" Start autocompletion from ncm2 first character entered
let g:ncm2#complete_length = 1



nnoremap <F5> :call LanguageClient_contextMenu()<CR>
"nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <M-q> :call LanguageClient_textDocument_hover()<CR>
" nmap <buffer> <M-x> <plug>DeopleteRustShowDocumentation
" nmap <silent> <M-x> <plug>DeopleteRustShowDocumentation
" imap <buffer> <M-x> <plug>DeopleteRustShowDocumentation
nnoremap <silent> <M-f> :call LanguageClient_textDocument_formatting()<CR>
nnoremap <silent> <M-l> :call LanguageClient_textDocument_rangeFormatting()<CR>
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
" let g:python_host_prog="/home/home/junk/anaconda/envs/py2/bin/python"
" let g:python3_host_prog="/home/home/junk/anaconda/envs/maelstrom/bin/python3.6"
" let g:deoplete#sources#jedi#python_path = '/home/home/junk/anaconda/envs/maelstrom/bin/python'
" let g:deoplete#sources#jedi#server_timeout = 60
let g:SuperTabDefaultCompletionType = "<c-n>"
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 1

" Python settings
" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" ALE setting
let g:airline#extensions#ale#enabled = 1
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


" Snippers setup up.
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<m-s>"
let g:UltiSnipsJumpForwardTrigger="<m-s>"
let g:UltiSnipsJumpBackwardTrigger="<m-z>"
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
let g:UltiSnipsRemoveSelectModeMappings = 0

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" CtrlP settings
"let g:ctrlp_map = ''
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" Vim-CtrlP-CmdPalette settings
let g:ctrlp_cmdpalette_execute = 1

"nmap <m-p> :CtrlPCmdPalette<CR>
nmap <M-p> :CtrlPCmdPalette<CR>
" Open file menu
" nnoremap <Leader>o :CtrlP<CR>
" Open buffer menu
nnoremap <Leader>b :CtrlPBuffer<CR>
" Open most recently used files
nnoremap <Leader>f :CtrlPMRUFiles<CR>

" fzf settings
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

"let g:ctrlp_user_command = 'rg %s -type f'        " MacOSX/Linux<Paste>
"let g:ctrlp_user_command = 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'        " MacOSX/Linux<Paste>
let g:ctrlp_user_command = 'fd --type f'
