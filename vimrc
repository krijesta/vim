set nocompatible " use vim settings (rather than vi)

set backspace=indent,eol,start " allow backspace over everthing
set nobackup                   " do not keep backup file
set history=50                 " keep 50 lines of command history
set ruler                      " show cursor position
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching
set lines=24 columns=85

command! W :w " allow saving via :W
let mapleader = ","

" Search highlighting toggle
nnoremap <F11> :set hlsearch! hlsearch?<CR>
nnoremap <A-S-F11> :set hls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set nohls " search highlighting on by default

" Cycling through buffers
nnoremap <A-Right> :bnext<CR>
nnoremap <A-Left>  :bprevious<CR>
nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprevious<CR>
nmap     <C-l> :Bclose<CR>
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
:nnoremap <F5> :w<CR> :!runhaskell <C-R>=expand("%:p")<CR><CR>
:nnoremap <F6> :w<CR> :make<CR>
:nnoremap <F7> :w<CR> :HLint<CR>

" Files & Tags
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :TlistToggle<CR>

" Code indenting and formatting
filetype plugin on
filetype indent on
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set foldmethod=marker

" Ctags
set tags=tags;/

" Compatibility with different operating systems
function! Load(relative_path)
  if has("win32") || has("win64")
    exec "source ~/vimfiles/" . a:relative_path
  else
    exec "source ~/.vim/" . a:relative_path
  endif
endfunction

" Font
if has("win32") || has("win64")
  set guifont=DejaVu_Sans_Mono:h14:cANSI
elseif has("gui_mac") || has("gui_macvim")
  set guifont=Menlo:h18
else
  set guifont=Monospace\ 15
endif

" Color scheme
syntax on
call Load("enable16colors.vim")
colorscheme jellybeans
set number
set numberwidth=5

" Vim
au Bufenter *.vim,*vimrc setlocal tabstop=2
au Bufenter *.vim,*vimrc setlocal shiftwidth=2

" CDL
au BufNewFile,BufRead *.cdl set filetype=c
au BufNewFile,BufRead *.cdl set noautoindent
au BufNewFile,BufRead *.cdl set nosmartindent
au BufNewFile,BufRead *.cdl set nocindent

" Gitolite
au BufNewFile,BufRead gitolite.conf,*/gitolite-admin/conf/* set filetype=gitolite
au BufNewFile,BufRead {,.}gitolite.rc,example.gitolite.rc set filetype=perl

" HTML
au FileType html setlocal tabstop=2
au FileType html setlocal shiftwidth=2

" CSS
au FileType css setlocal tabstop=2
au FileType css setlocal shiftwidth=2

" C#
au FileType cs setlocal tabstop=4
au FileType cs setlocal shiftwidth=4
au FileType cs setlocal noexpandtab
au FileType cs compiler msbuild
au FileType cs let b:ws_show=1
au FileType cs let b:ws_flags='est'
au FileType cs call RefreshWhitespace()

" Visual Studio Settings
au BufNewFile,BufRead *.vssettings set filetype=xml

" Markdown
au BufNewFile,BufRead *.mkd,*.md set filetype=mkd
au BufRead *.mkd,*.md set ai formatoptions=tcroqn2 comments=n:&gt;

" Ruby
au BufNewFile,BufRead *.rb,*.ru set filetype=ruby
au FileType ruby setlocal tabstop=2
au FileType ruby setlocal shiftwidth=2
au FileType ruby let g:rubycomplete_buffer_loading = 1
au FileType ruby let g:rubycomplete_classes_in_global = 1
au FileType ruby let g:rubycomplete_include_object = 1
au FileType ruby let g:rubycomplete_include_objectspace = 1

" Object J
au BufNewFile,BufRead *.j set filetype=objj
au BufNewFile,BufRead *.sj set filetype=javascript

" C#
au FileType cs setlocal noexpandtab

" F#
au BufNewFile,BufRead *.fs set filetype=fs

" GML
au BufNewFile,BufRead *.gml set filetype=config

" Arduino
au BufNewFile,BufRead *.pde set filetype=arduino
au FileType arduino set autoindent
au FileType arduino set smartindent
au FileType arduino set cindent

" Haskell
au BufNewFile,BufRead *.hs,*.hsc,*.lhs set filetype=haskell
au BufNewFile,BufRead *.lhs set syntax=lhaskell
au FileType haskell compiler ghc
au FileType haskell setlocal tabstop=4
au FileType haskell setlocal shiftwidth=4
let hs_highlight_types = 1
let hs_highlight_boolean = 1

" Haskell Cabal
au BufNewFile,BufRead *.cabal set filetype=cabal
au FileType cabal setlocal tabstop=2
au FileType cabal setlocal shiftwidth=2

function! HLint()
  try
    compiler hlint
    make
  finally
    compiler ghc
  endtry
endfunction

command! HLint :call HLint()

function! s:RunShellCommand(cmdline)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1,a:cmdline)
  call setline(2,substitute(a:cmdline,'.','=','g'))
  execute 'silent $read !'.escape(a:cmdline,'%#')
  setlocal nomodifiable
  1
endfunction

command! -complete=file -nargs=+ Run call s:RunShellCommand(<q-args>)

" Other scripts
call Load("whitespace.vim")
