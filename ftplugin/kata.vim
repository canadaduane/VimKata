" Vim filetype plugin
" Language:		VimKata
" Maintainer:		Duane Johnson

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" let b:undo_ftplugin = "setl cms< inc<"

set commentstring=#%s foldmethod=marker

" create an answer block from a group of non /^$/ lines
nmap <leader>pa /^$<cr>o<esc>NNo<esc>zf/^$/e<cr>A Answer:<esc>zc
" create a practice block from a group of non /^$/ lines
nmap <leader>pp /^$<cr>y?<cr>`]pj
" delete a practice block made up of a group of non /^$/ lines
nmap <leader>pd /^$<cr>d?<cr>
nmap <leader>pn zM/^[^#]<cr>zo
nmap <leader>pe Go{{{1<cr><esc>Di  practice_text  answer#}}}?^#{I

function! KataRenumber()
  let b:k_count = 1
  exe ":g/^(\\d\\+/s//\\='('.b:k_count/ | let b:k_count += 1"
  norm ``
endfunction
nnoremap <buffer> <silent> <LocalLeader>kr :call KataRenumber()<cr>

" vim:set sw=2:
