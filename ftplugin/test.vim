
setlocal statusline=Time:\ \ %{ShowBufferTime()}

function! Renumber() range
  let b:k_count = 1
  exe a:firstline . ',' . a:lastline . "g/^(\\d\\+/s//\\='('.b:k_count/ | let b:k_count += 1"
endfunction

function! GroupRenumber()
  let group_boundary = '^\[.\{-}\]$'
  " Locate the boundary of the group we're in
  let firstline  = search(group_boundary,'bnW') + 1
  let lastline   = search(group_boundary, 'nW') - 1
  if lastline < 0
    let lastline = line('$')
  endif
  exe firstline . ',' . lastline 'call Renumber()' 
endfunction

function! NextQuestion()
  call search("^(\\d\\+)")
  normal j
endfunction

function! NextQuestionWithPrep()
  call StopRecording()
  call NextQuestion()
  call ExecutePreparation()
  if !exists("g:StartBufferTime")
    let g:StartBufferTime = GetClock()
  endif
  let g:StartQuestionTime = GetClock()
  call StartRecording()
endfunction

function! PrevQuestion()
  call ThisQuestion()
  normal k
  call ThisInput()
endfunction

function! ThisQuestion()
  call search("^(\\d\\+)", "bc")
endfunction

function! ThisInput()
  call ThisQuestion()
  normal j
endfunction

function! ThisAnswer()
  call ThisQuestion()
  call search("^>")
  normal ll
endfunction

function! ThisPreparationLine()
  call ThisQuestion()
  let prepline = search("^<", "nW", search("^(\\d\\+)", "nW"))
  return prepline
endfunction

function! ExecuteAnswer()
  call ThisAnswer()
  exe "normal \"ay$"
  call ThisInput()
  exe "normal @a"
endfunction

function! ExecutePreparation()
  let prepline = ThisPreparationLine()
  if prepline > 0
    exe prepline + "G"
    normal ll
    exe "normal \"ay$"
    call ThisInput()
    exe "normal @a"
  else
    call ThisInput()
  end
endfunction

function! GetClock()
  let l:now = (strftime("%I") * 3600) + (strftime("%M") * 60) + (strftime("%S"))
  return l:now
endfunction

function! StartRecording()
  exe "normal qY"
endfunction

function! StopRecording()
  exe "normal q"
endfunction

function! ClearRecording()
  let @y = ""
endfunction

function! ShowBufferTime()
  let l:now = GetClock()
  if exists("g:StartBufferTime")
    let l:diff = l:now - g:StartBufferTime
    return l:diff
  else
    return 0
  endif
endfunction

function! CalcCPM()
  let l:now = GetClock()
  let l:diff = l:now - g:StartQuestionTime
  if l:diff <= 0
    return 0
  else
    let l:cpm = strlen(@y) * 60 / l:diff
    return l:cpm
  endif
endfunction

" maps
nnoremap Q :call NextQuestionWithPrep()<CR>
nnoremap <LocalLeader>kn NextQuestion()<CR>
nnoremap <LocalLeader>kp PrevQuestion()<CR>


