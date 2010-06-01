
set statusline=Time:\ \ %{ClockDiff()}\ sec.\ Chars:\ %{Chars()}\ CPM:\ %{CalcCPM()}

function! ClockInit()
  let s:clock = (strftime("%I") * 3600) + (strftime("%M") * 60) + (strftime("%S"))
endfunction

function! ClockDiff()
  let l:now = (strftime("%I") * 3600) + (strftime("%M") * 60) + (strftime("%S"))
  return (l:now - s:clock)
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

function! Chars()
  let l:len = strlen(@y)
  return len
endfunction

function! CalcCPM()
  call StopRecording()
  let l:diff = ClockDiff()
  if l:diff <= 0
    call StartRecording()
    return 0
  else
    call StartRecording()
    let l:cpm = strlen(@y) * 60 / ClockDiff() 
    return l:cpm
  endif
endfunction

" set updatetime=1000
" autocmd! CursorHold * call Timer() 
" autocmd! CursorHoldI * call Timer()
function! Timer() 
  call feedkeys("f\e") 
  " let &ro=&ro 
endfunction 


call ClockInit()
call ClearRecording()
call StartRecording()
echo @y
