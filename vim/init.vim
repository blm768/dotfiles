" Includes snippets from the Vim Tips wiki and maybe a couple of other places

set nocompatible

"
" Plugin setup
"

call plug#begin()
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/LnL7/vim-nix'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-sleuth.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/junegunn/fzf.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/zefei/vim-wintabs.git'

if has("nvim-0.6.0")
    Plug 'neovim/nvim-lspconfig'
endif
call plug#end()

" Configure NERDTree
" Don't let NERDTree keep vim open:
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" LSP
if has("nvim-0.6.0")
lua << EOF
    local lsp = require("lspconfig")
    lsp.clangd.setup{}
    lsp.rnix.setup{}
    lsp.rust_analyzer.setup{}
EOF
endif

"
" Editing options
"

set backspace=indent,eol,start

set shiftwidth=4
set tabstop=4
set noexpandtab

set autoindent
set copyindent

"
" Filetype options
"

filetype plugin on
filetype plugin indent on

" Use the GLSL syntax file for GLSL stuff.
autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

"
" Command options
"

set incsearch

set wildmode=longest,list
set shellslash

"
" Display options
"

set scrolloff=2
set number
set cursorline
set showmatch

"
" Misc. options
"

set mouse=a

if executable('rg')
    set grepprg=rg\ --vimgrep
endif

"
" Commands and mappings
"

" Used to write files if I forget to run Vim as root
cmap w!! w !sudo tee % >/dev/null

" More intelligent indentation on blank lines
function! IndentWithI()
    if len(getline('.')) == 0
        return "_S"
    else
        return "i"
    endif
endfunction
noremap <expr> i IndentWithI()

" Quick window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" FZF bindings

noremap <C-p> :FZF<CR>

" Wintabs

map <Leader>j <Plug>(wintabs_previous)
map <Leader>k <Plug>(wintabs_next)
map <Leader>q <Plug>(wintabs_close)
map <C-T>u <Plug>(wintabs_undo)
map <C-T>o <Plug>(wintabs_only)
map <C-W>c <Plug>(wintabs_close_window)
map <C-W>o <Plug>(wintabs_only_window)
command! Tabc WintabsCloseVimtab
command! Tabo WintabsOnlyVimtab
