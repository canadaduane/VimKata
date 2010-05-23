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

nnoremap Q :call search("(\\d\\+)") <Bar> normal j<Cr>

" vim:set sw=2:
