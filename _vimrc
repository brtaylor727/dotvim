"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
set nocompatible
filetype off

execute pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Autocommand Control
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
if has("autocmd")
    " Enable file type detection.
    filetype plugin indent on

    autocmd FocusLost * :wa

    autocmd BufEnter * :syntax sync fromstart
    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!
    " For all text files set 'textwidth' to 80 characters.
    "autocmd FileType text setl textwidth=80

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
               \ if line("'\"") > 0 && line("'\"") <= line("$") |
               \   exe "normal g`\"" |
               \ endif
    augroup END

    autocmd BufNewFile,BufRead *.R setf r
    autocmd BufRead .Rprofile setf r
    autocmd BufNewFile,BufRead *.str setf charmm

    "autocmd BufWritePost .vimrc source $MYVIMRC

    autocmd FileType perl setl complete+=k~/.vim_extras/every_perl_module.txt
    autocmd FileType * exe('setl dict+='.$VIMRUNTIME.'/syntax/'.&filetype.'.vim')
endif

set modelines=0

set tabstop=4 "An indentation level every four columns"
set softtabstop=4 "unify
set shiftwidth=4 "Indent/outdent by four columns"
set expandtab "Convert all tabs typed into spaces"
set shiftround "Always indent/outdent to the nearest tabstop"

if v:version >= 703
    " settings new to Vim 7.3
    set relativenumber
    "set undofile
    "set cc=+1
endif

set number "line numbering

" tame the searching/moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch

nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

" bracket matching
set hlsearch
nnoremap <tab> %
vnoremap <tab> %

syntax enable
set hidden " hide buffers instead of closing them
set history=1000 " How many lines of history to remember
set cf " enable error files and error jumping
set fileformats=unix
set viminfo+=! " make sure it can save viminfo
set iskeyword+=$,%,#,-,: " none of these should be word dividers, so make them not be
set showmode
set showcmd "display incomplete commands

set title
set titleold=""

set listchars=tab:▸\ ,eol:¬,trail:_

set nowrap
set formatoptions=qrn1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Theme/Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
if ! has("gui_running") 
    set t_Co=256
endif

set background=dark
"let g:solarized_termcolors=256
colorscheme default

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Vim UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
set linespace=0 " space it out a little more (easier to read)
set wildmenu " turn on wild menu
set ruler " Always show current positions along the bottom
set cmdheight=2 " the command bar is 2 high
set lazyredraw " do not redraw while running macros (much faster)
set backspace=2 " make backspace work normal
set backspace=indent,eol,start " backspace over everything in insert mode
set whichwrap+=<,>,h,l  " backspace and cursor keys wrap to
set whichwrap+=~,[,]
set shortmess=atI " shortens messages to avoid 'press a key' prompt
set report=0 " tell us when anything is changed via :...
set winminheight=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Visual Cues
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
set mat=5 " how many tenths of a second to blink matching brackets for
set so=10 " Keep 10 lines (top/bottom) for scope
set vb t_vb=
set noerrorbells " no noises
set laststatus=2 " always show the status line
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set shortmess+=r " use "[RO]" for "[readonly]" to save space in the message line:
set ttyfast " send lines to terminal faster

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Text Formatting/Layout
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
set autoindent
set copyindent
set smartindent
set wrapmargin=2
set smarttab " use tabs at the start of a line, spaces elsewhere

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
set nofoldenable " Turn on folding
set foldmethod=indent " Make folding indent sensitive
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen-=search " don't open folds when you search into them
set foldopen-=undo " don't open folds when you undo stuff

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

map <up> <nop>
map <down> <nop>
map <left> <Home>
map <right> <End>
nnoremap ; :

let mapleader=","
nmap <silent> <leader>p :set paste!<CR><Bar>:echo "Paste: " . strpart("OffOn", 3 * &paste, 3)<CR>
nmap <silent> <leader>r :set wrap!<CR><Bar>:echo "Wrap: " . strpart("OffOn", 3 * &wrap, 3)<CR>
nmap <leader>l :set list!<CR>
nmap <leader>e :sp $MYVIMRC<CR>
nmap <leader>so :source $MYVIMRC<CR>
nmap <leader>o :only<CR>
nmap <leader>m :w<CR>:make<CR>
nmap <leader>w :w<CR>
nmap <leader>q :wqa<CR>

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%

nnoremap <leader>ft Vatzf
nnoremap <leader>a :Ack 

" working with split windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h :sp<CR><C-w>k

nmap <silent> <leader><space> :nohlsearch<CR>
nmap <silent> <leader>n :NERDTreeToggle<CR>
nmap <silent> <leader>y :SyntasticToggleMode<CR>
nmap <silent> <leader>t :TlistToggle<CR>

" don't use Ex mode, use Q for formatting
vmap Q gq
nmap Q gqap

nmap :q1 :q!
nmap :qwa :xa
nmap :Wqa :xa
nmap :Wq :wq
nmap :Qa :qa

noremap <Space> <PageDown>
noremap <BS> <PageUp>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Useful abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
iab Ydate <C-R>=strftime("%Y/%m/%d")<CR>
iab Ydt <C-R>=strftime("%Y/%m/%d %H:%M")<CR>
iab perline %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
iab bline """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab teh the
iab textbg textbf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Other stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp
set browsedir=buffer

set wildchar=<TAB>
set report=0
set uc=75 " after 75 characters write a swap file

cnoremap <C-A> <Home>
cnoremap <C-E> <End>

set timeout
set ttimeout
set timeoutlen=400

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Spelling
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
if has("spell")
    " turn spelling off by default
    set nospell
    nmap <silent> <leader>s :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>

    " they were using white on white
    highlight PmenuSel ctermfg=black ctermbg=lightgray

    " limit it to just the top 10 items
    set sps=best,10
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Set the Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
set statusline=%<%f\ %y%h%m%r%=%l,%c\ \ \ \ [textwidth=%{&textwidth}]\ %P\ %{strftime('%H:%M')}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Suffixes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
"set suffixes=~,.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar,.o

"Plugin Options
"set comments=b:#,:%,n:>

set dictionary+=/usr/share/dict/words
set complete+=k
