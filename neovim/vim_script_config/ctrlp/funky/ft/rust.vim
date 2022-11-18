" Language: Rust
" Author: Takahiro Yoshihara
" License: The MIT License

function! ctrlp#funky#ft#rust#filters()
  let filters = [
        \ { 'pattern': '\m\Cfn[\t ]\+',
        \   'formatter': [] },
        \ { 'pattern': '\v^[ \t]*(export)?[ \t]*((mod)|(struct)|(trait)|(impl)|(enum)|(fn))[ \t]+([a-zA-Z0-9_]+)',
        \   'formatter': []},
  \ ]
  return filters
endfunction
