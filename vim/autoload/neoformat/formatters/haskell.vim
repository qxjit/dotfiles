function! neoformat#formatters#haskell#enabled() abort
  return ['project_haskell_format', 'project_stylish_haskell']
endfunction

function! neoformat#formatters#haskell#project_haskell_format() abort
  return {
        \ 'exe': './haskell-format',
        \ 'stdin': 1
        \ }
endfunction

function! neoformat#formatters#haskell#project_stylish_haskell() abort
  return {
        \ 'exe': './stylish-haskell',
        \ 'stdin': 1
        \ }
endfunction

