" Vim filetype plugin
" Language:		VimKata
" Maintainer:		Duane Johnson

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal commentstring=#%s foldmethod=marker
setlocal nospell nohlsearch

function! KataRenumber() range
  let b:k_count = 1
  exe a:firstline . ',' . a:lastline . "g/^(\\d\\+/s//\\='('.b:k_count/ | let b:k_count += 1"
endfunction
nnoremap <buffer> <silent> <LocalLeader>kr ms :1,$ call KataRenumber()<cr>`s

function! KataGroupRenumber()
  let group_boundary = '^\[.\{-}\]$'

  " Locate the boundary of the group we're in
  let firstline  = search(group_boundary,'bnW') + 1
  let lastline   = search(group_boundary, 'nW') - 1
  if lastline < 0
    let lastline = line('$')
  endif

  exe firstline . ',' . lastline 'call KataRenumber()' 
endfunction
nnoremap <buffer> <silent> <LocalLeader>kgr ms :call KataGroupRenumber()<cr>`s

function! KataNextQuestion()
  call search("(\\d\\+)")
  normal j
endfunction
nnoremap <buffer> <silent> Q :call KataNextQuestion()<cr>
nnoremap <buffer> <silent> <LocalLeader>kn :call KataNextQuestion()<cr>

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
