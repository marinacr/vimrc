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
