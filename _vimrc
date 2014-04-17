""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &compatible
    set nocompatible
endif
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'kien/ctrlp.vim'
Plugin 'zeis/vim-kolor'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/syntastic'
Plugin 'taglist'
Plugin 'matchit'

set background=dark
colorscheme kolor

function! InsertStatuslineColor(mode)
    if a:mode == 'i'
        hi statusline guibg=Yellow ctermfg=6 guifg=Black ctermbg=0
    elseif a:mode == 'r'
        hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
    else
        hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
    endif
endfunction

" default the statusline to green when entering Vim
hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommand Control
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
    filetype plugin indent on
    au FocusLost * :wa
    au BufEnter * :syntax sync fromstart
    au FileType * setl textwidth=80
    au BufEnter * lcd %:p:h
    au FileType * exe('setl dict+='.$VIMRUNTIME.'/syntax/'.&filetype.'.vim')

    " When editing a file, always jump to the last known cursor position.
    au BufReadPost *
               \ if line("'\"") > 0 && line("'\"") <= line("$") |
               \   exe "normal g`\"" |
               \ endif

    au BufNewFile,BufRead *.R setf r
    au BufRead .Rprofile setf r
    au BufNewFile,BufRead *.md setf markdown
    "au BufWritePost .vimrc source $MYVIMRC
    "au BufWritePost _vimrc source $MYVIMRC

    "au InsertEnter * call InsertStatuslineColor(v:insertmode)
    "au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

    "au WinLeave * set nocursorline nocursorcolumn
    "au WinEnter * set cursorline cursorcolumn

    au BufWritePre * :%s/\s\+$//e
    au FileType c,cpp,java set matchpairs+==:;
endif

set modeline
set modelines=3
set nrformats=

set tabstop=4 "An indentation level every four columns"
set softtabstop=4 "unify
set shiftwidth=4 "Indent/outdent by four columns"
set expandtab "Convert all tabs typed into spaces"
set shiftround "Always indent/outdent to the nearest tabstop"

" settings new to Vim 7.3
if v:version >= 703
    set relativenumber
    set colorcolumn=+3
else
	set number
endif

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap
set formatoptions=qrn1
set linespace=0 " space it out a little more (easier to read)
set ruler " Always show current positions along the bottom
set cmdheight=2 " the command bar is 2 high
set lazyredraw " do not redraw while running macros (much faster)
set backspace=indent,eol,start " backspace over everything in insert mode
set whichwrap=<,>,[,],b,s
set shortmess=atI
set report=0
set winminheight=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Cues
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set matchtime=5
set matchpairs+=<:>
set scrolloff=10
set visualbell t_vb=
set noerrorbells
set laststatus=2 " always show the status line
set ttyfast " send lines to terminal faster

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set copyindent
set smartindent
set wrapmargin=2
set smarttab " use tabs at the start of a line, spaces elsewhere
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch

nnoremap / /\v
vnoremap / /\v

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable
set foldmethod=indent " Make folding indent sensitive
set foldlevel=100
set foldopen-=undo " don't open folds when you undo stuff
"set foldopen-=search " don't open folds when you search into them

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
inoremap <up> <nop>
vnoremap <up> <nop>
inoremap <down> <nop>
vnoremap <down> <nop>
inoremap <left> <nop>
vnoremap <left> <nop>
inoremap <right> <nop>
vnoremap <right> <nop>
nnoremap ; :
"nnoremap : ;

let mapleader=','
nmap <silent><leader>p :set paste!
            \<CR><Bar>:echo "Paste: "
            \. strpart("OffOn", 3 * &paste, 3)<CR>
nmap <silent><leader>r :set wrap!
            \<CR><Bar>:echo "Wrap: "
            \. strpart("OffOn", 3 * &wrap, 3)<CR>
nmap <leader>l :set list!<CR>
nmap <leader>e :sp $MYVIMRC<CR>
nmap <leader>so :source $MYVIMRC<CR>
nmap <silent><leader>o :only<CR>
nmap <leader>ma :w<CR>:make<CR>
nmap <leader>m :marks<CR>
nmap <leader>w :w<CR>
nmap <leader>q :wqa<CR>

"cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
"map <leader>ew :e %%
"map <leader>es :sp %%
"map <leader>ev :vsp %%

nnoremap <leader>ft Vatzf

" working with split windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h :sp<CR><C-w>k

nmap <silent><leader><space> :nohlsearch<CR>
nmap <silent><leader>y :SyntasticToggleMode<CR>
nmap <silent><leader>t :TlistToggle<CR>

" don't use Ex mode, use Q for formatting
vmap Q gq
nmap Q gqap

nmap :q1 :q!
nmap :qwa :xa
nmap :Wqa :xa
nmap :Wq :wq
nmap :Qa :qa

noremap <Space> <PageDown>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Useful abbrevs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab <silent> ydate <C-R>=strftime("%Y/%m/%d")<CR>
iab <silent> ydu <C-R>=strftime("%Y_%m_%d")<CR>
iab <silent> ydt <C-R>=strftime("%Y/%m/%d %H:%M")<CR>
iab <silent> yti <C-R>=strftime("%H:%M")<CR>
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

set dict+=/usr/share/dict/words
set complete=.,w,b,u,t,i,k

set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,.git
set wildchar=<TAB>

set browsedir=buffer
set report=0
set uc=75 " after 75 characters write a swap file

cnoremap <C-A> <Home>
cnoremap <C-E> <End>

set timeout ttimeout timeoutlen=250

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spelling
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("spell")
    " turn spelling off by default
    set nospell
    nmap <silent><leader>s :set spell!
                \ <CR><Bar>:echo "Spell Check: "
                \. strpart("OffOn", 3 * &spell, 3)<CR>

    highlight PmenuSel ctermfg=black ctermbg=lightgray
    set spellsuggest=best,3
endif

set suffixes=~,.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar,.o

" Ack and Ctrl-P integration
nnoremap <leader>a :Ack
nnoremap \ :Ack<SPACE>
let g:ctrlp_use_caching = 0
nnoremap K :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>
nmap <c-w><c-]> "tyaw:stjump <c-r>t<cr>
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader><leader> :xa<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the Status Line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%f
set statusline+=\ %y
set statusline+=%m
set statusline+=%r
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=\ %=
set statusline+=\ C:%c
set statusline+=\ L:%l
set statusline+=\ [%p%%]
set statusline+=\ tw=%{&tw}
set statusline+=\ B:%n
set statusline+=\ %{strftime('%H:%M')}
