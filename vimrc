set nocompatible " use vim settings (rather than vi)

set backspace=indent,eol,start " allow backspace over everthing
set nobackup                   " do not keep backup file
set history=50                 " keep 50 lines of command history
set ruler                      " show cursor position
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching

" Search highlighting toggle
nnoremap <F11> :set hlsearch! hlsearch?<CR>
nnoremap <A-S-F11> :set hls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set nohls " search highlighting on by default

" Cycling through buffers
nnoremap <A-Right> :bnext<CR>
nnoremap <A-Left> :bprevious<CR>
set hidden " don't discard buffer when switching away

" make tabs show complete (no broken on two lines)
let g:miniBufExplTabWrap = 1
" If you use other explorers like TagList you can (As of 6.2.8) set it at 1:
let g:miniBufExplModSelTarget = 1
" If you would like to single click on tabs rather than double clicking on them to goto the selected buffer.
let g:miniBufExplUseSingleClick = 1

" Replace word under cursor
" usage: type \s on "foo" and then type "bar/g" to
"        replace foo with bar
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Make
:nnoremap <F5> :w<CR> :!runhaskell <C-R>=expand("%:t")<CR><CR>
:nnoremap <F6> :w<CR> :make<CR>
:nnoremap <F7> :w<CR> :HLint<CR>

" NERDTree
:nnoremap <F2> :NERDTreeToggle<CR>

" Code indenting and formatting
filetype plugin on
filetype indent on
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set foldmethod=marker

" Compatibility with different operating systems
function! Load(relative_path)
  if has("win32") || has("win64")
    exec "source ~/vimfiles/" . a:relative_path
  else
    exec "source ~/.vim/" . a:relative_path
  endif
endfunction


" Font and color scheme
syntax on
set guifont=Monospace\ 15
call Load("enable16colors.vim")
colorscheme jellybeans

" Windows
if has("win32") || has("win64")
  set guifont=DejaVu_Sans_Mono:h14:cANSI
endif

" Vim
au Bufenter *.vim,*vimrc setlocal tabstop=2
au Bufenter *.vim,*vimrc setlocal shiftwidth=2

" Gitolite
au BufNewFile,BufRead gitolite.conf,*/gitolite-admin/conf/* setf gitolite
au BufNewFile,BufRead {,.}gitolite.rc,example.gitolite.rc setf perl

" HTML
au Bufenter *.html setlocal tabstop=2
au Bufenter *.html setlocal shiftwidth=2

" Ruby
au BufNewFile,BufRead *.rb,*.ru set filetype=ruby
au Bufenter *.rb setlocal tabstop=2
au Bufenter *.rb setlocal shiftwidth=2

" Object J
au BufNewFile,BufRead *.j setf objj
au BufNewFile,BufRead *.sj setf javascript

" Haskell
au BufNewFile,BufRead *.hs,*.hsc,*.lhs setf haskell
au BufNewFile,BufRead *.cabal setf cabal
au Bufenter *.hs,*.hsc,*.lhs compiler ghc
au Bufenter *.hs,*.hsc,*.lhs setlocal tabstop=4
au Bufenter *.hs,*.hsc,*.lhs setlocal shiftwidth=4
let hs_highlight_types = 1
let hs_highlight_boolean = 1

command! HLint :call HLint()

function! HLint()
  try
    compiler hlint
    make
  finally
    compiler ghc
  endtry
endfunction

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
