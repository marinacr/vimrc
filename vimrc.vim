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
set nu

nnoremap <C-M><BS> :qa<CR>
nnoremap <C-M><C-H> :help<CR>
nnoremap <C-M><C-R> :source ~/.vimrc<CR>

nnoremap <C-M><C-W> :cw<CR>
nnoremap <C-M><S-W> :cclose<CR>
nnoremap <C-M><C-L> :lw<CR>
nnoremap <C-M><C-T> :TlistToggle<CR>
nnoremap <C-M><C-B> :make \| cw<CR>
nnoremap <C-M><S-B> :make clean all \| cw<CR>
nnoremap <C-M><C-F>* :exe "vimgrep /" . expand("<cword>") . "/gj ".expand("%") \| cw<CR>
nnoremap <C-M><C-G>* :exe "vimgrep /" . expand("<cword>") . "/gj **" \| cw<CR>
nnoremap <C-M><C-F>y :exe "vimgrep /" . escape(@", '/\') . "/gj ".expand("%") \| cw<CR>
nnoremap <C-M><C-G>y :exe "vimgrep /" . escape(@", '/\') . "/gj **" \| cw<CR>
nnoremap <C-M><C-F>/ :exe "vimgrep /" . escape(@/, '/\') . "/gj ".expand("%") \| cw<CR>
nnoremap <C-M><C-G>/ :exe "vimgrep /" . escape(@/, '/\') . "/gj **" \| cw<CR>

nnoremap <C-F><C-O> :e .<CR>
inoremap <C-F><C-O> <ESC>:e .<CR>
nnoremap <C-F><C-W> :w<CR>
inoremap <C-F><C-W> <ESC>:w<CR>a
nnoremap <C-F><C-T> :%retab<CR>
inoremap <C-F><C-T> <ESC>:%retab<CR>a
nnoremap <C-F><C-F> gg=G<CR>
inoremap <C-F><C-F> <ESC>gg=G<CR>a

nnoremap <C-B><C-N> :bnext<CR>
inoremap <C-B><C-N> <ESC>:bnext<CR>a
nnoremap <C-B><C-V> :bprevious<CR>
inoremap <C-B><C-V> :bprevious<CR>a
nnoremap <C-B><C-B> :b #<CR>
inoremap <C-B><C-B> :b #<CR>a
nnoremap <C-B><C-D> :bdelete<CR>
inoremap <C-B><C-D> <ESC>:bdelete<CR>a

nnoremap <C-@> :let @/ = "" <CR>

colorscheme desert
if has("gui_running")
    colorscheme desert
    nnoremap <C-O> :browse confirm e<CR>
    inoremap <C-O> <ESC>:browse confirm e<CR>
    set guioptions-=T
    if has("gui_gtk2")
        set guifont=Monospace\ 9
    elseif has("x11")
        set guifont=-*-courier-medium-r-normal-*-*-160-*-*-m-*-*
    else
        set guifont=Courier_New:h11:cDEFAULT
    endif
endif

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

let mapleader = "!"

" highlight trailing spaces on/off \wn / \wf
nnoremap <Leader>wn :call EnableHighlightTrailingWS()<CR>
nnoremap <Leader>wf :call DisableHighlightTrailingWS()<CR>

" open a preview window and jump to tag under cursor
nnoremap <Leader>p :ptjump <C-R><C-W><CR>
nnoremap <Leader>s :stjump <C-R><C-W><CR>

set showtabline=1 " show tabline only if there are at least two tab
set wildmenu " show menu when pressing TAB in command mode
set wildmode=list:longest " complete with longest common string
set wildignore=*.o,*.obj,*.bak,*.exe,*~ " do not complete with some pattern
