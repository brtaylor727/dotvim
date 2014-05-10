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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommand Control
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
    filetype plugin indent on
    au BufWritePre * :%s/\s\+$//e
    au FocusLost * :wa
    "au BufEnter * :syntax sync fromstart
    au BufRead * :set tw=80
    "au BufEnter * lcd %:p:h

    " When editing a file, always jump to the last known cursor position.
    au BufReadPost *
               \ if line("'\"") > 0 && line("'\"") <= line("$") |
               \   exe "normal g`\"" |
               \ endif

    au BufNewFile,BufRead *.txt :setf txt
    au BufNewFile,BufRead *.txt :set spell
    au BufNewFile,BufRead *.md :setf markdown

    au FileType c,cpp,java set matchpairs+==:;
    au FileType xml,html set matchpairs+=<:>

    augroup Toggle autocmd!
        function! InsertStatuslineColor(mode)
            if a:mode == 'i'
                hi StatusLine guibg=Yellow ctermbg=114 ctermfg=0 guifg=Black
            elseif a:mode == 'r'
                hi StatusLine guibg=Purple ctermbg=114 ctermfg=0 guifg=Black
            else
                hi StatusLine guibg=DarkRed ctermbg=114 ctermfg=0 guifg=Black
            endif
        endfunction

        au InsertEnter * call InsertStatuslineColor(v:insertmode)
        au InsertLeave *
                    \ hi StatusLine ctermfg=0 ctermbg=247

        "au WinLeave * set nocursorline nocursorcolumn
        "au WinEnter * set cursorline cursorcolumn
    augroup end

    augroup NoSimultaneousEdits autocmd!
        au SwapExists * let v:swapchoice = 'o'
        "au SwapExists * echomsg ErrorMsg
        au SwapExists * echo 'Duplicate edit session (readonly)'
        au SwapExists * echohl None
        au SwapExists * sleep 2
    augroup end
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
    set colorcolumn=+0
else
	set number
endif

syntax enable
set hidden " hide buffers instead of closing them
set history=1000 " How many lines of history to remember
set cf " enable error files and error jumping
set fileformats=unix
set viminfo+=! " make sure it can save viminfo
set iskeyword+=$,%,#,-,: " none of these should be word dividers
set showmode
set showcmd "display incomplete commands

set title
set titleold=""

set listchars=tab:▸\ ,eol:¬,trail:_
set listchars+=precedes:<
set listchars+=extends:>

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
set scrolloff=10
set visualbell t_vb=
set noerrorbells
set laststatus=2 " always show the status line
set ttyfast " send lines to terminal faster
set ttyscroll=5

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set copyindent
"set smartindent
set wrapmargin=2
set ignorecase
set smartcase
set gdefault
set hlsearch
set incsearch
set showmatch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable
set foldmethod=indent " Make folding indent sensitive
set foldlevel=100
set foldopen-=undo " don't open folds when you undo stuff

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap / /\v
vnoremap / /\v

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
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap <TAB> %
vnoremap <TAB> %

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
iab <silent> ydu   <C-R>=strftime("%Y_%m_%d")<CR>
iab <silent> ydt   <C-R>=strftime("%Y/%m/%d %H:%M")<CR>
iab <silent> yti   <C-R>=strftime("%H:%M")<CR>
iab perline %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
iab bline """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab teh the
iab textbg textbf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set dict+=/usr/share/dict/words
set complete=.,b,w,u,t,i
set completeopt=menu,preview
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,.git

set browsedir=buffer
set report=0
set updatecount=75 " after 75 characters write a swap file

set timeout ttimeout timeoutlen=250

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spelling
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("spell")
    set nospell
    nmap <silent><leader>s :set spell!
                \ <CR><Bar>:echo "Spell Check: "
                \. strpart("OffOn", 3 * &spell, 3)<CR>

    highlight PmenuSel ctermfg=black ctermbg=lightgray
    set spellsuggest=best,3
endif

set suffixes=~,.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar,.o

" Ack and Ctrl-P integration
nnoremap \ :Ack<SPACE>
nnoremap K :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>
nmap <c-w><c-]> "tyaw:stjump <c-r>t<cr>
let g:ctrlp_use_caching=1
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

runtime macros/matchit.vim
