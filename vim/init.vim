let s:truecolor=($COLORTERM == "truecolor")

if s:truecolor
  set termguicolors
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'commit': '6188c5e' }

Plug 'mileszs/ack.vim', { 'commit': '36e40f9' }

Plug 'flazz/vim-colorschemes', { 'commit': 'eab3157' }

Plug 'kien/ctrlp.vim', { 'commit': '564176f' }

Plug 'neovimhaskell/haskell-vim', { 'commit': 'a5302e0' }

Plug 'raichoo/purescript-vim', { 'commit': 'bd19ded' }

Plug 'fatih/vim-go', { 'commit': '8575d9e' }

Plug 'ElmCast/elm-vim', { 'commit': 'ae53153' }

Plug 'sbdchd/neoformat', { 'commit': '4dba93d' }

Plug 'qxjit/setcolors.vim', { 'commit': 'da71d38' }

Plug 'jreybert/vimagit', { 'commit': '85c25ff' }

Plug 'skwp/greplace.vim', { 'commit': 'a34dff3' }

Plug 'tpope/vim-surround', { 'commit': 'e49d6c2' }

Plug 'tpope/vim-repeat', { 'commit': '8106e14' }

Plug 'gcmt/taboo.vim', { 'commit': '1367baf' }

call plug#end()

syntax on
filetype plugin indent on

" silent! here suppresses errors about the colorscheme
" missing so that we can run :PluginInstall the first
" time without getting an error.
silent! colorscheme jellybeans

function! s:GitLog()
  let l:name=bufname('%')
  let l:type=getbufvar('%', '&buftype', 'ERROR')
  let l:basecmd="PAGER= git log --graph"

  if l:type == "" && glob(l:name) != ""
    let l:cmd=l:basecmd." ".l:name
  else
    let l:cmd=l:basecmd
  endif

  split
  resize
  execute "terminal ".l:cmd
  set nomodified
  execute "file git log ".l:name
  noremap <silent> <buffer> q :bdelete!<CR>
endfunction

command! -nargs=0 GitLog call s:GitLog()

let mapleader=" "

noremap <Leader>sa :Ack!<Space>
noremap <Leader>sr :Gsearch<Space>
noremap <Leader>sw "zyiw:Ack! z<CR>

noremap <silent> <Leader>t :NERDTreeToggle<CR>
noremap <silent> <Leader>a :CtrlP<CR>

noremap <silent> <Leader>gs :Magit<CR>
noremap <silent> <Leader>gl :GitLog<CR>

noremap <silent> <Leader>n :cnext<CR>
noremap <silent> <Leader>p :cprevious<CR>

" Switch to alternate (previous) buffer in a window. See
" :help alternate
noremap <silent> <Leader><Tab> :buffer #<CR>
noremap <silent> <Leader>w <C-w>
noremap <silent> <Leader>w/ :vsplit<CR>
noremap <silent> <Leader>w- :split<CR>
noremap <silent> <Leader>fs :write<CR>
noremap <silent> <Leader>fS :wall<CR>
noremap <silent> <Leader>bb :CtrlPBuffer<CR>

tnoremap <Esc> <C-\><C-n>
tnoremap <C-o> <Esc>

let g:ctrlp_use_caching=0

if executable('rg')
  let g:ctrlp_user_command='rg %s --files --color never'
  let g:ackprg='rg --smart-case --no-heading --vimgrep'
elseif executable('ag')
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
  let g:ackprg='ag --smart-case --vimgrep'
endif

set number
set shiftwidth=2
set tabstop=2
set expandtab
" Workaround for nvim not always calling :set nopaste after paste,
" which results in :set noexpandtab being turned on globally :(
au InsertLeave * set nopaste
set nowrap
set incsearch
set hlsearch

set nobackup
set undofile
set undodir=~/.config/nvim/undodir

" Highlight trailing whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
" Set up highlight group & retain through colorscheme changes
highlight ExtraWhitespace ctermbg=88 guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=88 guibg=red

" Highlight too-long lines
autocmd BufRead,InsertEnter,InsertLeave * 2match LineLengthError /\%76v.*/
highlight LineLengthError term=underline cterm=underline gui=underline
autocmd ColorScheme * highlight LineLengthError term=underline cterm=underline gui=underline

" Make line numbers a big more visible with a color matching jellybeans
highlight linenr term=none cterm=none ctermfg=179 ctermbg=none gui=none guifg=#fad07a guibg=NONE

" Make the status bar and tabline look nicer
highlight StatusLine ctermbg=238 ctermfg=112 guibg=#404040 guifg=#b0cc55
highlight StatusLineNC ctermfg=249 guifg=#909090
highlight TabLine ctermbg=238 ctermfg=249 guibg=#404040  guifg=#909090
highlight TabLineSel ctermbg=238 ctermfg=112 guibg=#404040 guifg=#b0cc55

" Make the colors look nicer in the terminal, if supported.
if s:truecolor || has('gui_running')
  " Normal Colors
  let g:terminal_color_0='#000000' " black
  let g:terminal_color_1='#cf6a4c' " red
  let g:terminal_color_2='#99ad6a' " green
  let g:terminal_color_3='#fad07a' " yellow
  let g:terminal_color_4='#7aa6da' " blue
  let g:terminal_color_5='#c397d8' " magenta
  let g:terminal_color_6='#70c0ba' " cyan
  let g:terminal_color_7='#dddddd' " white

  " Bright colors
  let g:terminal_color_8='#666666'  " black
  let g:terminal_color_9='#cc3334'  " red
  let g:terminal_color_10='#9ec400' " green
  let g:terminal_color_11='#e7c547' " yellow
  let g:terminal_color_12='#7aa6da' " blue
  let g:terminal_color_13='#b77ee0' " magenta
  let g:terminal_color_14='#54ced6' " cyan
  let g:terminal_color_15='#ffffff' " white
endif

augroup fmt
  autocmd!
  autocmd BufWritePre *.hs undojoin | Neoformat
augroup END

