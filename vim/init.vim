set termguicolors

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'commit': 'a172d7cfcb4fe9b927dcc24184204fc89d826301' }

Plug 'mileszs/ack.vim', { 'commit': '36e40f9ec91bdbf6f1adf408522a73a6925c3042' }

Plug 'flazz/vim-colorschemes', { 'commit': 'eab315701f4627967fd62582eefc4e37a3745786' }

Plug 'kien/ctrlp.vim', { 'commit': '564176f01d7f3f7f8ab452ff4e1f5314de7b0981' }

Plug 'neovimhaskell/haskell-vim', { 'commit': '430b529224c5f9ae53b148f814b7b1fc82b8b525' }

Plug 'raichoo/purescript-vim', { 'commit': 'bd19dedebc7420565b8aec111e59217da838db59' }

Plug 'fatih/vim-go', { 'commit': '8575d9e3c9e23508f9b7d0c3992cb683b1e47ae6' }

Plug 'ElmCast/elm-vim', { 'commit': 'ae5315396cd0f3958750f10a5f3ad9d34d33f40d' }

Plug 'sbdchd/neoformat', { 'commit': '230e12121b43ba428bd147639a59f0ac5e72b5cc' }

Plug 'qxjit/setcolors.vim', { 'commit': 'da71d38c73815678dafa9c121b1e0a86676a2bc7' }

call plug#end()

syntax on
filetype plugin indent on

colorscheme jellybeans
hi StatusLine guibg=#404040 guifg=#b0cc55
hi StatusLineNC guifg=#909090

function! s:SearchReplace(search,replace)
  " This assumes that the :Ack! command supports --case-sensitive to
  " override any default behavior that would make the cdo s/// not
  " behave as expected. It would be better to abstract this out
  " in some way that I don't have time to think about right now.
  "
  " Using :cdo has the following shortcomings and tradeoffs that are known
  "   * The y/n/q/a etc options apply on the current hit *only*
  "     * Use Ctrl-C Abort
  "   * Saving after each file to avoid building up a bunch of unsaved buffers
  "   * Files are not syntax highlighted (inside the cdo)
  execute ":Ack! --case-sensitive ".a:search
  execute ":cdo s/".a:search."/".a:replace."/c | :w | update"
endfunction

command! -nargs=+ SearchReplace call s:SearchReplace(<f-args>)

let mapleader=" "

map <Leader>sa :Ack!<Space>
map <Leader>sr :SearchReplace<Space>
map <Leader>sw "zyiw:Ack! z<CR>

map <silent> <Leader>t :NERDTreeToggle<CR>
map <silent> <Leader>ch :HighlightColumnAdd<CR>
map <silent> <Leader>co :HighlightColumnOne<CR>
map <silent> <Leader>cc :HighlightColumnOff<CR>
map <silent> <Leader>a :CtrlP<CR>
map <silent> <Leader>n :cn<CR>
map <silent> <Leader>p :cp<CR>
map <silent> <Leader><Tab> :buf #<CR>
map <silent> <Leader>w 

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

augroup fmt
  autocmd!
  autocmd BufWritePre *.hs undojoin | Neoformat
augroup END
