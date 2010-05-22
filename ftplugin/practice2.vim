" Vim filetype plugin
" Language:		Practice
" Maintainer:		Duane Johnson

" Only do this when not done yet for this buffer
" if exists("b:did_ftplugin")
"   finish
" endif
" let b:did_ftplugin = 1

" let b:undo_ftplugin = "setl cms< inc<"

"setlocal commentstring=//\ %s
"setlocal omnifunc=csscomplete#CompleteCSS

"let &l:include = '^\s*>'
syntax region Function start="^[a-zA-Z0-9]" end="\n"
syntax region Define start="^>" end="\n"
syntax region Comment start="#" end="\n"

set commentstring=#%s foldmethod=marker

" create an answer block from a group of non /^$/ lines
nmap <leader>pa /^$<cr>o<esc>NNo<esc>zf/^$/e<cr>A Answer:<esc>zc
" create a practice block from a group of non /^$/ lines
nmap <leader>pp /^$<cr>y?<cr>`]pj
" delete a practice block made up of a group of non /^$/ lines
nmap <leader>pd /^$<cr>d?<cr>
nmap <leader>pn zM/^[^#]<cr>zo

nmap <leader>pe Go{{{1<cr><esc>Di  practice_text  answer#}}}?^#{I

" I was then thinking of having an @n macro that does a @d and then jumps
" forward to the next challenge.  Or something like that. :-)
" But I want to give it more thought - checking the answer, for example...

" vim:set sw=2:
