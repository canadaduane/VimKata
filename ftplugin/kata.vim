" Vim filetype plugin
" Language:		VimKata
" Maintainer:		Duane Johnson

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

au BufNewFile,BufRead *.kata  set filetype=kata

setlocal commentstring=#%s foldmethod=marker
setlocal nospell nohlsearch

function! KataRenumber()
  let b:k_count = 1
  exe ":g/^(\\d\\+/s//\\='('.b:k_count/ | let b:k_count += 1"
  norm ``
endfunction
nnoremap <buffer> <silent> <LocalLeader>kr :call KataRenumber()<cr>

function! KataNextQuestion()
  call search("(\\d\\+)")
  normal j
endfunction
nnoremap <buffer> <silent> Q :call KataNextQuestion()<cr>

function! KataThisQuestion()
  call search("(\\d\\+)", "bc")
endfunction
nnoremap <buffer> <silent> <LocalLeader>kq :call KataThisQuestion()<cr>

function! KataThisInput()
  call KataThisQuestion()
  normal j
endfunction
nnoremap <buffer> <silent> <LocalLeader>ki :call KataThisInput()<cr>

function! KataThisAnswer()
  call KataThisQuestion()
  call search("^>")
  normal ll
endfunction
nnoremap <buffer> <silent> <LocalLeader>ka :call KataThisAnswer()<cr>

function! KataExecuteAnswer()
  call KataThisAnswer()
  exe "normal \"ay$"
  call KataThisInput()
  exe "normal @a"
endfunction
nnoremap <buffer> <silent> <LocalLeader>ke :call KataExecuteAnswer()<cr>

" vim:set sw=2:
