set nocompatible " use vim settings (rather than vi)

set backspace=indent,eol,start " allow backspace over everthing
set nobackup                   " do not keep backup file
set history=50                 " keep 50 lines of command history
set ruler                      " show cursor position
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching

" Search highlighting toggle
nnoremap <F10> :set hls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>
nnoremap <F11> :nohls<CR>
set hls " search highlighting on by default

" Cycling through buffers
nnoremap <A-Right> :bnext<CR>
nnoremap <A-Left> :bprevious<CR>
set hidden " don't discard buffer when switching away

" Replace word under cursor
" usage: type \s on "foo" and then type "bar/g" to
"        replace foo with bar
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Make
:nnoremap <F5> :w<CR> :!runhaskell <C-R>=expand("%:t")<CR><CR>
:nnoremap <F6> :w<CR> :make<CR>

" Code indenting and formatting
filetype plugin on
filetype indent on
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set foldmethod=marker

" Font and color scheme
syntax on
set guifont=Monospace\ 15
exe "source ~/.vim/themes/enable16colors.vim"
exe "source ~/.vim/themes/jake.vim"

" Windows
if has("win32") || has("win64")
  set rtp+=~/.vim
  set guifont=DejaVu_Sans_Mono:h14:cANSI
endif

" Vim
au Bufenter *.vim,*vimrc setlocal tabstop=2
au Bufenter *.vim,*vimrc setlocal shiftwidth=2

" HTML
au Bufenter *.html setlocal tabstop=2
au Bufenter *.html setlocal shiftwidth=2

" Ruby
au Bufenter *.rb setlocal tabstop=2
au Bufenter *.rb setlocal shiftwidth=2

" Haskell
au Bufenter *.hs compiler ghc
au Bufenter *.hs setlocal tabstop=2
au Bufenter *.hs setlocal shiftwidth=2
let g:haddock_browser = "firefox-3.5"
let g:haddock_indexfiledir = expand("~/.vim/cache/")

if !filewritable(g:haddock_indexfiledir)
  echoerr g:haddock_indexfiledir . " is not writable"
  finish
end

function! HaskellComment()
  if getline(".") =~ '--'
    let hls=@/
    s/^--//
    let @/=hls
  else
    let hls=@/
    s/^/--/
    let @/=hls
  endif
endfunction

map <C-k> :call HaskellComment()<CR>
