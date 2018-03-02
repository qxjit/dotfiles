set t_Co=256

execute pathogen#infect()
syntax on
filetype plugin indent on

colorscheme wombat256

map <silent> <Leader>nt :NERDTreeToggle<CR>
map <silent> <Leader>nr :NERDTree<CR>
map <silent> <Leader>ch :HighlightColumnAdd<CR>
map <silent> <Leader>co :HighlightColumnOne<CR>
map <silent> <Leader>cc :HighlightColumnOff<CR>
map <silent> <Leader>a :CtrlP<CR>

let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching=0
let g:ackprg = 'ag --vimgrep --smart-case'
let g:stylish_haskell_command='./stylish-haskell'
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
