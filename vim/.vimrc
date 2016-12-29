set backspace=indent,eol,start
aunmenu Help.
aunmenu Window.
let no_buffers_menu=1
set mousemodel=popup
set ruler
set completeopt-=preview
set gcr=a:blinkon0
set ttyfast
syntax on
set novisualbell       
set t_Co=256
set enc=utf-8	     " utf-8 по дефолту в файлах
set ls=2             " всегда показываем статусбар
set incsearch	     " инкреминтируемый поиск
set hlsearch	     " подсветка результатов поиска
"set nu	             " показывать номера строк
set scrolloff=5	     " 5 строк при скролле за раз
" настройка на Tab
set smarttab
set expandtab
set shiftwidth=2
set softtabstop=8
set tabstop=2
" отключаем бэкапы и своп-файлы
set nobackup 	     " no backup files
set nowritebackup    " only in case you don't want a backup file while editing
set noswapfile 	     " no swap files

" прячем панельки
set guioptions-=m   " меню
set guioptions-=T    " тулбар
set guioptions-=r   "  скроллбары

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"Plugin 'scrooloose/syntastic'
"---------=== Code/project navigation ===-------------
Plugin 'scrooloose/nerdtree' 	    	" Project and file navigation
"Plugin 'scrooloose/nerdcommenter' 	    	" Project and file navigation
"Plugin 'majutsushi/tagbar'          	" Class/module browser
"------------------=== Other ===----------------------
Plugin 'bling/vim-airline'   	    	" Lean & mean status/tabline for vim
"Plugin 'fisadev/FixedTaskList.vim'  	" Pending tasks list
"Plugin 'tpope/vim-surround'	   	" Parentheses, brackets, quotes, XML tags, and more
"--------------=== Snippets support ===---------------"
"Plugin 'garbas/vim-snipmate'		" Snippets manager
"Plugin 'MarcWeber/vim-addon-mw-utils'	" dependencies #1
"Plugin 'tomtom/tlib_vim'		" dependencies #2
"Plugin 'honza/vim-snippets'		" snippets repo
"---------------=== Languages support ===-------------
Plugin 'klen/python-mode'	        " Python mode
"Plugin 'davidhalter/jedi-vim' 		" Jedi-vim autocomplete plugin
"Plugin 'mitsuhiko/vim-jinja'		" Jinja support for vim
"Plugin 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim
Plugin 'aperezdc/vim-template' 
"---------------=== Themes ===-------------
"Plugin 'crusoexia/vim-monokai'
"Plugin 'aliou/moriarty.vim'
"Plugin 'itchyny/landscape.vim'
"Plugin 'ajh17/spacegray.vim'
"Plugin 'wombat256.vim'
"Plugin 'michalbachowski/vim-wombat256mod.git'
"Plugin 'lokaltog/vim-distinguished'
"Plugin 'ujihisa/unite-colorscheme'
"Plugin 'chriskempson/vim-tomorrow-theme'
"Plugin 'tomasr/molokai'
Plugin 'romainl/apprentice'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"colorscheme monokai
"colorscheme moriarty
"set background=dark
"set background=light
"colorscheme landscape
"colorscheme spacegray
"colorscheme distinguished
"colorscheme molokai
"" colorscheme apprentice
try
  colorscheme apprentice
catch /^Vim\%((\a\+)\)\=:E185/
  " skip color
endtry
source ~/.vim/pymode.vim
source ~/.vim/nerdtree.vim
source ~/.vim/tagbar.vim
source ~/.vim/hotkeys.vim
source ~/.vim/filetypes.vim
source ~/.vim/templates.vim
