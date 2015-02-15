" Basic settings
set nocompatible            " Eliminate backwards-compatability
set number                  " Enable line numbers
set ruler                   " Turn on the ruler
set cursorline              " Highlight current line
set showcmd
set wildmenu                " visual autocomplete for command menu
set lazyredraw              " redraw only when we need to.
syntax on                   " Syntax highlighting
set background=dark
" set background=light
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termcolors=16
colorscheme solarized

" Indentation
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

filetype indent on

" Plugins

filetype off                  " Req'd for vundle
set rtp+=~/.vim/bundle/Vundle.vim " Vundle prelude
call vundle#begin()              " ^

Plugin 'gmarik/vundle'
" Plugin 'scrooloose/nerdtree'
" Plugin 'kien/ctrlp.vim' " Ctrl-P has been replaced by Unite!
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'altercation/vim-colors-solarized'
Plugin 'shougo/unite.vim'
Plugin 'shougo/vimproc.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'shougo/neossh.vim'

set laststatus=2	" Req for single file vim-airline view

" Unite settings

" Ctrl-P fuzzy search
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:vimfiler_as_default_explorer=1
let g:unite_prompt='» '
let g:unite_split_rule = 'botright'
if executable('ag')
	let g:unite_source_grep_command='ag'
	let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
	let g:unite_source_grep_recursive_opt=''
endif
nnoremap <silent> <c-p> :Unite -no-split file file_mru file_rec/async<cr>

" Unite find
nnoremap <space>/ :Unite grep:.<cr>


" Post-vundle
call vundle#end()
filetype plugin indent on     " Req'd for vundle

