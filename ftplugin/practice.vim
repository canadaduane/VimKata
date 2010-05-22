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

set commentstring=#%s
" vim:set sw=2:
