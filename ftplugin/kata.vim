function! KataRenumber()
  let b:k_count = 1
  exe ":g/^(\\d\\+/s//\\='('.b:k_count/ | let b:k_count += 1"
  norm ``
endfunction
nnoremap <buffer> <silent> <LocalLeader>kr :call KataRenumber()<cr>

nnoremap Q :call search("(\\d\\+)") <Bar> normal j<Cr>
