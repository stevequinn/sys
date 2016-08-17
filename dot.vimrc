" Basic settings
set nocompatible            " Eliminate backwards-compatability
set number                  " Enable line numbers
set ruler                   " Turn on the ruler
set cursorline              " Highlight current line
set showcmd
set wildmenu                " visual autocomplete for command menu
set showmatch               " highlight matching [{()}]
set autoread                " auto read a file on focus
set updatetime=250
set ignorecase              " ignore case when searching
set title                   " Change the terminals title

syntax enable               " Syntax highlighting
" set background=dark
set background=light
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
" let g:solarized_termcolors=16
" colorscheme solarized
" colorscheme monokai
colorscheme badwolf

" Indentation
set autoindent
set copyindent
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4
set expandtab       " tabs are spaces

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Using // tells vim to use the full path when creating
" swap files. This will avoid name collision when working
" on files of the same name.
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

filetype indent on

" Plugins

filetype off                  " Req'd for vundle
set rtp+=~/.vim/bundle/Vundle.vim " Vundle prelude
call vundle#begin()              " ^

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim' " Ctrl-P has been replaced by Unite!
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
" Plugin 'altercation/vim-colors-solarized'
Plugin 'sjl/badwolf'
Plugin 'othree/html5.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'kshenoy/vim-signature'
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'
Plugin 'easymotion/vim-easymotion'
" Plugin 'shougo/unite.vim'
" Plugin 'shougo/vimproc.vim'
" Plugin 'Shougo/neomru.vim'
" Plugin 'shougo/neossh.vim'
set laststatus=2	" Req for single file vim-airline view

" Ctr-P fuzzy search
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Markdown
let g:vim_markdown_folding_disabled=1

" Post-vundle
call vundle#end()
filetype plugin indent on     " Req'd for vundle

