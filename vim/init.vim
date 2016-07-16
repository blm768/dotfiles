set nocompatible

"Plugin setup
if has('win32')
	set rtp+=~/AppData/Local/nvim/bundle/Vundle.vim
else
	set rtp+=~/.config/nvim/bundle/Vundle.vim
endif

call vundle#begin() 
Plugin 'VundleVim/Vundle.vim'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'Xuyuanp/nerdtree-git-plugin'
call vundle#end()

"Configure NERDTree
"Don't let NERDTree keep vim open:
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

filetype plugin on
filetype plugin indent on

autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

set backspace=indent,eol,start

set shiftwidth=4
set tabstop=4
set noexpandtab

set autoindent
set copyindent

set number
set scrolloff=2

set wildmode=longest,list
set shellslash

set incsearch

syntax on
if has("gui_running")
	set background=light
	colorscheme solarized
	if has("win32") || has("win64")
		set guifont=Courier_New:h9:cANSI
	end
end
set cursorline
set showmatch

"Used to write files if I forget to run Vim as root
cmap w!! w !sudo tee % >/dev/null

"More intelligent indentation on blank lines
function! IndentWithI()
	if len(getline('.')) == 0
		return "_S"
	else
		return "i"
	endif
endfunction
noremap <expr> i IndentWithI()

"Quick window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"To compensate for fat fingers
noremap <F1> <Esc>

"Faster command mode
nmap ; :
noremap ;; ;
