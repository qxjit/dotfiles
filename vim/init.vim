set termguicolors

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

Plug 'tpope/vim-fugitive', { 'commit': '614e20b' }

call plug#end()

syntax on
filetype plugin indent on

" silent! here suppresses errors about the colorscheme
" missing so that we can run :PluginInstall the first
" time without getting an error.
silent! colorscheme jellybeans

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

noremap <Leader>sa :Ack!<Space>
noremap <Leader>sr :SearchReplace<Space>
noremap <Leader>sw "zyiw:Ack! z<CR>

noremap <silent> <Leader>t :NERDTreeToggle<CR>
noremap <silent> <Leader>a :CtrlP<CR>

noremap <silent> <Leader>ch :HighlightColumnAdd<CR>
noremap <silent> <Leader>co :HighlightColumnOne<CR>
noremap <silent> <Leader>cc :HighlightColumnOff<CR>

noremap <silent> <Leader>gs :Gstatus<CR>
noremap <silent> <Leader>gd :Gdiff<CR>
noremap <silent> <Leader>gc :Gcommit<CR>
noremap <silent> <Leader>gb :Gblame<CR>

noremap <silent> <Leader>n :cn<CR>
noremap <silent> <Leader>p :cp<CR>
noremap <silent> <Leader><Tab> :buf #<CR>
noremap <silent> <Leader>w <C-w>

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
highlight linenr term=none cterm=none ctermfg=yellow ctermbg=none gui=none guifg=#fad07a guibg=NONE

augroup fmt
  autocmd!
  autocmd BufWritePre *.hs undojoin | Neoformat
augroup END

