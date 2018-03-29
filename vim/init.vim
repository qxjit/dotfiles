set termguicolors

execute pathogen#infect()
syntax on
filetype plugin indent on

colorscheme jellybeans
hi StatusLine guibg=#404040 guifg=#b0cc55
hi StatusLineNC guifg=#909090

map <silent> <Leader>nt :NERDTreeToggle<CR>
map <silent> <Leader>nr :NERDTree<CR>
map <silent> <Leader>ch :HighlightColumnAdd<CR>
map <silent> <Leader>co :HighlightColumnOne<CR>
map <silent> <Leader>cc :HighlightColumnOff<CR>
map <silent> <Leader>a :CtrlP<CR>

let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching=0

if executable('rg')
  let g:ackprg='rg --smart-case --no-heading --vimgrep'
elseif executable('ag')
  let g:ackprg='ag --smart-case --vimgrep'
endif

cnoreabbrev Ag Ack

set number
set shiftwidth=2
set tabstop=2
set expandtab
set nowrap
set incsearch
set hlsearch

silent !mkdir -p /tmp/vim
set dir=/tmp/vim//

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
