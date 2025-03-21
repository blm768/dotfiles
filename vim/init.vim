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
Plug 'https://github.com/mattn/emmet-vim.git'
Plug 'https://github.com/mhinz/vim-grepper.git'
Plug 'https://github.com/mhinz/vim-signify.git'
Plug 'https://github.com/moll/vim-bbye.git'
Plug 'https://github.com/rbong/vim-flog'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-sleuth.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/junegunn/fzf.git'
Plug 'https://github.com/junegunn/fzf.vim.git'
Plug 'https://github.com/junegunn/gv.vim.git'
Plug 'https://github.com/wellle/targets.vim.git'

if has("nvim-0.8.0")
    Plug 'akinsho/bufferline.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
endif

if has("nvim-0.7.0")
    Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
endif

if has("nvim-0.6.0")
    Plug 'neovim/nvim-lspconfig'
endif

if has("nvim-0.5.0")
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lualine/lualine.nvim'
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

" Lualine
if has("nvim-0.5.0")
lua << EOF
require('lualine').setup {
    options = {
        icons_enabled = true,
        section_separators = '',
        component_separators = '',
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'branch'},
    },
    extensions = {'fugitive', 'fzf', 'nerdtree'},
}
EOF
endif

" Bufferline
if has("nvim-0.8.0")
set termguicolors
lua << EOF
require("bufferline").setup {
    options = {
        diagnostics = "nvim_lsp",
    },
}
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
" Shell options
"

if has('win32')
    let &shell =  'powershell'
    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    set shellquote= shellxquote=
endif


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
" Make vim-signify update more frequently
set updatetime=100

if executable('rg')
    set grepprg=rg\ --vimgrep
endif

"
" Commands and mappings
"

nnoremap <Space> <Nop>
let mapleader = " "

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

" Buffer navigation

nnoremap <leader>h :bprev<cr>
nnoremap <leader>l :bnext<cr>
nnoremap <leader>q :Bdelete<cr>

" Emmet

let g:user_emmet_install_global = 0

" FZF bindings

noremap <C-p> :FZF<CR>

" Grepper

let g:grepper = {}
let g:grepper.tools = ['rg', 'git', 'findstr']

nmap <leader>g :Grepper -tool rg<cr>
nmap <leader>G :Grepper -tool git<cr>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Toggleterm
if has("nvim-0.7.0")
lua << EOF
local toggleterm = require("toggleterm")
toggleterm.setup{
    open_mapping = [[<c-\>]],
}
EOF
endif
