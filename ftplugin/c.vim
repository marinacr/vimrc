" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

""""""""""""""""""""""""""""""""""""""""
" C langage
"""""""""""""""""""""""""""""""""""""""

" Add include guard in header file
function! CHdrGuard()
    let l:filename = expand("%:t")
    let l:guard = "__" . substitute(toupper(l:filename), "\\.", "_", "g") . "__"
    let l:guard = substitute(l:guard, "-", "_", "g")
    exec "normal ggO#ifndef " . l:guard
    exec "normal o#define " . l:guard
    exec "normal Go#endif /* " . l:guard . " */"
    exec "normal O"
endfunction
command! -bang -nargs=0 CHdrGuard call CHdrGuard()



" Insert a comment at end of line with comment in argument
function! CCommentInsertion(comment)
    exec "normal A /* " . a:comment . " */"
endfunction
command! -bang -nargs=1 CCommentInsertion call CCommentInsertion(<args>)

"Launch GDB
function! LaunchGDB(gdb, elf_file)
    let g:termdebug_popup = 0
    let g:termdebug_wide = 163
    let g:termdebugger = a:gdb
    exec "packadd termdebug"
    exec "Termdebug " . a:elf_file
endfunction
command! -complete=file -nargs=+ LaunchGDB call LaunchGDB(<f-args>)
command! -complete=file -nargs=+ GdbMultiarch call LaunchGDB("gdb-multiarch", <f-args>)

" indent argument split on multiple lines aligned on the first arg
" func(arg1,
"      arg2);
setlocal cinoptions+=(0

" return 1 when editing for zephyr
function! IsZephyr()
    let l:path = expand('%:p')
    if l:path =~ 'zephyr'
        return 1
    else
        return 0
    endif
endfunction

if (IsZephyr())
    setlocal shiftwidth=8
    setlocal tabstop=8
    setlocal noexpandtab
endif
