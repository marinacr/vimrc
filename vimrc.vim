filetype indent on
syntax on

set textwidth=78
set tabstop=4
set shiftwidth=4
set bs=2
set expandtab
set autoindent
set incsearch
set hlsearch
set modeline
set laststatus=2
set statusline=%<%f%h%m%r%=%{&ff}\ %l,%c%V\ %P
set encoding=utf-8
set fileformats=unix,mac,dos
set number " show line number
set scrolloff=5 "lines visible above and under cursor

nnoremap <C-M><C-R> :source ~/.vimrc<CR>

" Abbreviation in command mode to replace '%%' with the path of the current
" file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr <expr> %% expand('%:h')

colorscheme desert
if !has('gui_running')
    set t_Co=256
endif
"if has("gui_running")
"    colorscheme desert
"    nnoremap <C-O> :browse confirm e<CR>
"    inoremap <C-O> <ESC>:browse confirm e<CR>
"    set guioptions-=T
"    if has("gui_gtk2")
"        set guifont=Monospace\ 9
"    elseif has("x11")
"        set guifont=-*-courier-medium-r-normal-*-*-160-*-*-m-*-*
"    else
"        set guifont=Courier_New:h11:cDEFAULT
"    endif
"endif

let mapleader = "!"

" highlight trailing spaces on/off \wn / \wf
nnoremap <Leader>wn :call EnableHighlightTrailingWS()<CR>
nnoremap <Leader>wf :call DisableHighlightTrailingWS()<CR>

nnoremap <Leader>z :tjump <C-R><C-W><CR>
" open a preview window and jump to tag under cursor
nnoremap <Leader>p :ptjump <C-R><C-W><CR>
" split window
" jump to tag under cursor in a new window
nnoremap <Leader>s :stjump <C-R><C-W><CR>
nnoremap <Leader>t :tab split <CR> :tjump <C-R><C-W><CR>zt


set showtabline=1 " show tabline only if there are at least two tab
set wildmenu " show menu when pressing TAB in command mode
set wildmode=list:longest " complete with longest common string
set wildignore=*.o,*.obj,*.bak,*.exe,*~ " do not complete with some pattern

" Highlight trailing space, must be set before colorscheme command
" Based on https://vim.fandom.com/wiki/Highlight_unwanted_spaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=red
let g:highlight_trailing_ws = 1

" Match all whitespaces at end of line
function MatchTrailingWS()
    if g:highlight_trailing_ws == 1
        match ExtraWhitespace /\s\+$/
    endif
endfunction

" Match whitespaces at end of line except for current line
function MatchTrailingWSExceptCurrent()
    if g:highlight_trailing_ws == 1
        match ExtraWhitespace /\s\+\%#\@<!$/
    endif
endfunction

" Enable highlighting
function EnableHighlightTrailingWS()
    let g:highlight_trailing_ws = 1
    highlight ExtraWhitespace ctermbg=red guibg=red
    call MatchTrailingWS()
endfunction

" Disable highlighting
function DisableHighlightTrailingWS()
    let g:highlight_trailing_ws = 0
    highlight clear ExtraWhitespace
endfunction

call MatchTrailingWS()
autocmd WinEnter * call MatchTrailingWS()
autocmd InsertEnter * call MatchTrailingWSExceptCurrent()
autocmd InsertLeave * call MatchTrailingWS()
autocmd BufWinLeave * call clearmatches()

