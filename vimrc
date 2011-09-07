set nocompatible " use vim settings (rather than vi)

set hidden                     " don't discard buffer when switching away
set backspace=indent,eol,start " allow backspace over everthing
set nobackup                   " do not keep backup file
set history=50                 " keep 50 lines of command history
set ruler                      " show cursor position
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching
set autowrite                  " auto-save buffer on :make

command! W :w " allow saving via :W
let mapleader = ","

" File format / encoding
set fileformats=unix,dos

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" Compatibility with different operating systems
if has("win32") || has("win64")
  let g:vimdir = "~/vimfiles/"
  let ruby_path="C:\Ruby192"
else
  let g:vimdir = "~/.vim/"
endif
let g:vimrc = g:vimdir . "vimrc"

" Edit .vimrc
nnoremap <Leader>v :exec ":e " . g:vimrc<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd! BufWritePost *vimrc exec "source " . g:vimrc
endif

" Swap current character with next
nnoremap <silent> gc xph
" Swap current word with next
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>

" Run j macro
nnoremap <Space> @j

" Grep word under cursor, same file type
nnoremap <Leader>g
  \ :noautocmd lvim /\<lt><C-R><C-W>\>/gj
  \ **/*<C-R>=(expand("%:e")=="" ? "" : ".".expand("%:e"))<CR>
  \ <Bar> lw<CR>
" Grep word under cursor, all files
nnoremap <Leader>G
  \ :noautocmd lvim /\<lt><C-R><C-W>\>/gj
  \ **
  \ <Bar> lw<CR>

" Search highlighting toggle
nnoremap <F11> :set hlsearch! hlsearch?<CR>
nnoremap <A-S-F11> :set hls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>
set nohls " search highlighting off by default

" OS Copy+Paste
vnoremap <Leader>y "+y
nnoremap <Leader>p "+gpl
vnoremap <Leader>p :<C-U>call VPaste()<CR>
"inoremap <Leader>p <C-O>:call IPaste()<CR>

function! VPaste()
  normal gv
  normal "+P
  normal l
endfunction

function! IPaste()
  set virtualedit=all
  normal `^"+gP
  let &virtualedit = ""
endfunction

" Cycling through buffers
nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprevious<CR>
nnoremap <C-l> :bdelete<CR>
nnoremap <C-h> :b#<CR>
nnoremap <D-j> :tabnext<CR>
nnoremap <A-J> :tabnext<CR>
nnoremap <D-k> :tabprevious<CR>
nnoremap <A-K> :tabprevious<CR>

" Window resizing
nnoremap <D-left>    :vertical resize -5<cr>
nnoremap <C-S-left>  :vertical resize -5<cr>
nnoremap <D-down>    :resize +5<cr>
nnoremap <C-S-down>  :resize +5<cr>
nnoremap <D-up>      :resize -5<cr>
nnoremap <C-S-up>    :resize -5<cr>
nnoremap <D-right>   :vertical resize +5<cr>
nnoremap <C-S-right> :vertical resize +5<cr>

" Replace word under cursor
" usage: type \s on "foo" and then type "bar/g" to
"        replace foo with bar
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Make
nnoremap <F5> :w<CR> :!ghc -e main <C-R>=expand("%:p")<CR><CR>
nnoremap <F6> :w<CR> :make<CR>
nnoremap <F7> :w<CR> :HLint<CR>

" Files & Tags
nnoremap <Leader>r :CommandTFlush<CR>
nnoremap <F3> :TlistToggle<CR>
set wildignore=*.bak,*.dll,*dist,.exe,*.gif,*.hi,*.jpg,*.o,*.obj*,*.png,*.pyc,*.p_o,*.p_hi,_*/*
set wildmode=list:longest           " File completion bash-style


" Enable Pathogen
call pathogen#runtime_append_all_bundles()

" Code indenting and formatting
filetype off
filetype plugin on
filetype indent on
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set foldmethod=marker

" Tabularize
nnoremap <Leader>a= :Tabularize /[+&]\?=\+[>]\?<CR>
vnoremap <Leader>a= :Tabularize /[+&]\?=\+[>]\?<CR>
nnoremap <Leader>a- :Tabularize /-\+>\\|<-\+<CR>
vnoremap <Leader>a- :Tabularize /-\+>\\|<-\+<CR>
nnoremap <Leader>a{ :Tabularize /{<CR>:Tabularize /}<CR>
vnoremap <Leader>a{ :Tabularize /{<CR>:Tabularize /}<CR>
nnoremap <Leader>a; :Tabularize /:\zs/l0l1<CR>
vnoremap <Leader>a; :Tabularize /:\zs/l0l1<CR>
nnoremap <Leader>a, :Tabularize /,\zs/l0l1<CR>
vnoremap <Leader>a, :Tabularize /,\zs/l0l1<CR>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Ctags
set tags=tags;/

function! Load(relative_path)
  exec "source " . g:vimdir . a:relative_path
endfunction

" Font
if has("win32") || has("win64")
  set guifont=DejaVu_Sans_Mono:h14:cANSI
elseif has("gui_mac") || has("gui_macvim")
  set guifont=Inconsolata:h18,Menlo:h18
else
  set guifont=Monospace\ 15
endif

" Hide toolbar
set guioptions-=T

" Color scheme
syntax on
call Load("enable16colors.vim")
colorscheme jellybeans
set number
set numberwidth=5

" Vim
au FileType vim setlocal tabstop=2
au FileType vim setlocal shiftwidth=2

" ANTLR
au BufNewFile,BufRead *.g set syntax=antlr

" BNF
au BufNewFile,BufRead *.bnf set filetype=bnf

" CDL
au BufNewFile,BufRead *.cdl set filetype=c
au BufNewFile,BufRead *.cdl set noautoindent
au BufNewFile,BufRead *.cdl set nosmartindent
au BufNewFile,BufRead *.cdl set nocindent

" Gitolite
au BufNewFile,BufRead gitolite.conf,*/gitolite-admin/conf/* set filetype=gitolite
au BufNewFile,BufRead {,.}gitolite.rc,example.gitolite.rc set filetype=perl

" Javascript / JSON
au BufNewFile,BufRead *.json set filetype=javascript
au FileType javascript setlocal tabstop=2
au FileType javascript setlocal shiftwidth=2
au FileType javascript call EnableWhitespace('et')

" Coffeescript
au FileType coffee setlocal tabstop=2
au FileType coffee setlocal shiftwidth=2
au FileType coffee setlocal makeprg=coffee\ --compile\ --lint\ %\ $*
au FileType coffee call EnableWhitespace('et')

" HTML
au FileType html setlocal tabstop=2
au FileType html setlocal shiftwidth=2
au FileType html call EnableWhitespace('et')

" XML
au FileType xml setlocal tabstop=2
au FileType xml setlocal shiftwidth=2
au FileType xml call EnableWhitespace('et')

" CSS
au FileType css setlocal tabstop=2
au FileType css setlocal shiftwidth=2
au FileType css call EnableWhitespace('et')

" C#
au FileType cs setlocal tabstop=4
au FileType cs setlocal shiftwidth=4
au FileType cs setlocal noexpandtab
au FileType cs compiler msbuild
au FileType cs call EnableWhitespace('es')

" Visual Studio Settings
au BufNewFile,BufRead *.vssettings set filetype=xml

" PowerShell
au BufNewFile,BufRead *.ps1 set filetype=ps1
au FileType ps1 call EnableWhitespace('et')

" Markdown
au FileType markdown set ai comments=n:&gt;
au FileType markdown set textwidth=72 formatoptions=tcroqn2
au FileType markdown call EnableWhitespace('et')

" Ruby
au BufNewFile,BufRead *.rb,*.ru,rakefile,vagrantfile set filetype=ruby
au FileType ruby setlocal tabstop=2
au FileType ruby setlocal shiftwidth=2
au FileType ruby let g:rubycomplete_buffer_loading = 1
au FileType ruby let g:rubycomplete_classes_in_global = 1
au FileType ruby let g:rubycomplete_include_object = 1
au FileType ruby let g:rubycomplete_include_objectspace = 1
au FileType ruby call EnableWhitespace('et')

" Object J
au BufNewFile,BufRead *.j set filetype=objj
au BufNewFile,BufRead *.sj set filetype=javascript

" F#
au BufNewFile,BufRead *.fs set filetype=fs

" GML
au BufNewFile,BufRead *.gml set filetype=config

" Arduino
au BufNewFile,BufRead *.pde set filetype=arduino
au FileType arduino setlocal autoindent
au FileType arduino setlocal smartindent
au FileType arduino setlocal cindent

" C
au FileType c syntax match cType /\h\w*_t\W/me=e-1
au FileType c syntax match cConstant /\W[A-Z_][A-Z0-9_]*\W/ms=s+1,me=e-1

" Haskell
au BufNewFile,BufRead *.hs,*.hsc,*.lhs set filetype=haskell
au BufNewFile,BufRead *.lhs set syntax=lhaskell
au FileType haskell compiler ghc
au FileType haskell setlocal iskeyword+='
au FileType haskell setlocal tabstop=4
au FileType haskell setlocal shiftwidth=4
au FileType haskell call EnableWhitespace('et')
let hs_highlight_types = 1
let hs_highlight_boolean = 1

" Haskell - hoogle word under cursor
au FileType haskell nnoremap <Leader>h :!hoogle <C-r><C-w><CR>

" Haskell - sort then align imports
au FileType haskell nnoremap <Leader>ai
    \ vip:sort r /\u\.*/<CR> <Bar> :Tabularize /^import qualified\\|^import\\|^$<CR>

" Haskell Cabal
au BufNewFile,BufRead *.cabal set filetype=cabal
au FileType cabal setlocal tabstop=2
au FileType cabal setlocal shiftwidth=2
au FileType cabal call EnableWhitespace('et')

" Heist templates
au BufNewFile,BufRead *.tpl set filetype=html

" Alex lexer / Happy parser
au BufNewFile,BufRead *.x set filetype=alex
au FileType alex compiler ghc
au FileType alex setlocal makeprg=alex\ %\ &&\ ghc\ -e\ :q\ %:r.hs
au FileType alex call EnableWhitespace('et')
au BufNewFile,BufRead *.y set filetype=happy

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
