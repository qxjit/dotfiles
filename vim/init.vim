set termguicolors

execute pathogen#infect()
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
highlight LineLengthError ctermbg=58 guibg=gold4
autocmd ColorScheme * highlight LineLengthError ctermbg=58 guibg=gold4

augroup fmt
  autocmd!
  autocmd BufWritePre *.hs undojoin | Neoformat
augroup END
