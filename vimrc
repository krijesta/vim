" Use vim settings (rather than vi)
set nocompatible

set hidden                     " don't discard buffer when switching away
set nobackup                   " do not keep backup file
set incsearch                  " do incremental searching
set autowrite                  " auto-save buffer on :make
set ignorecase smartcase       " Smart case matching for search
set infercase                  " Smart case matching for autocompletion

" Mode lines are disabled by default on OSX, see CVE-2007-2438, re-enable them
set modelines=5

command! W :w " allow saving via :W
let mapleader = ","

" File format / encoding
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" Location of vimrc
let g:vimrc = "~/.vim/vimrc"

" Edit vimrc
nnoremap <Leader>v :exec ":e " . g:vimrc<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd! BufWritePost *vimrc exec "source " . g:vimrc
endif

" Swap current character with next
nnoremap <silent> gc xph
" Swap current word with next
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>

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
nnoremap <Leader><Leader> :set hlsearch! hlsearch?<CR>
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

" Cycling through buffers (C-L conflicts with clear in vim-sensible)
nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprevious<CR>
nnoremap <C-l> :bdelete<CR>
nnoremap <C-h> :b#<CR>

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

" Wildcard config for file listing / completion
set wildmode=list:longest " bash-style file completion
set wildignore=_*/*
set wildignore+=*.exe,.dll
set wildignore+=*.gif,*.jpg,*.png
set wildignore+=*.o,*.hi,*.p_o,*.p_hi,*.obj*,*.pyc
set wildignore+=dist/*,build/*,cmake/*,cabal-dev/*

" Vundle {{{
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Displays lines changed in the sign column, call :GitGutterToggle to
" show/hide
Bundle 'airblade/vim-gitgutter'
let g:gitgutter_enabled = 0

Bundle 'ap/vim-css-color'
Bundle 'gmarik/vundle'
Bundle 'kchmck/vim-coffee-script'
Bundle 'LargeFile'
Bundle 'loremipsum'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'bufexplorer.zip'
Bundle 'scrooloose/nerdtree'

" Neocomplcache - switch for YCM?
Bundle 'Shougo/neocomplcache'
Bundle 'ujihisa/neco-ghc'
let g:neocomplcache_enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Command-T
Bundle 'wincent/Command-T'
nnoremap <silent> <Leader>t :CommandT<CR>
nnoremap <silent> <Leader>b :CommandTBuffer<CR>
nnoremap <silent> <Leader>r :CommandTFlush<CR>

" Syntastic
Bundle 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['python'],
                           \ 'passive_filetypes': [] }
set balloondelay=100 " No use having this too big

" }}}

" Code indenting and formatting
filetype plugin on
filetype indent on
set tabstop=4
set shiftwidth=4
set expandtab
set foldmethod=marker

" Tabularize
nnoremap <Leader>a= :Tabularize /[+&]\?=\+[>]\?<CR>
vnoremap <Leader>a= :Tabularize /[+&]\?=\+[>]\?<CR>
nnoremap <Leader>a- :Tabularize /-\+>\\|<-\+<CR>
vnoremap <Leader>a- :Tabularize /-\+>\\|<-\+<CR>
nnoremap <Leader>at :Tabularize /:\+<CR>
vnoremap <Leader>at :Tabularize /:\+<CR>
nnoremap <Leader>ac :Tabularize /--<CR>
vnoremap <Leader>ac :Tabularize /--<CR>
nnoremap <Leader>a{ :Tabularize /{<CR>:Tabularize /}<CR>
vnoremap <Leader>a{ :Tabularize /{<CR>:Tabularize /}<CR>
nnoremap <Leader>a; :Tabularize /:\zs/l0l1<CR>
vnoremap <Leader>a; :Tabularize /:\zs/l0l1<CR>
nnoremap <Leader>a, :Tabularize /,\zs/l0l1<CR>
vnoremap <Leader>a, :Tabularize /,\zs/l0l1<CR>

" Mardown header formatting, insert a row of = or - below the current line
" This is a more complex version of `yypVr` which works in code with leading
" whitespace or comments
" nnoremap <Leader>= yypVr=
nnoremap <Leader>- yyp:call search('\w', 'c', line('.'))<CR>v$r-$
nnoremap <Leader>= yyp:call search('\w', 'c', line('.'))<CR>v$r=$

" TODO: There is an issue with this line, if you are inserting text
" in block visual mode and wish to type a bar is will break the block 
" insert
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" Swap the current table entry with the next one (see align below)
nnoremap <silent> g<Bar>
  \ T<Bar>
  \ :s/<Bar>\s\+\%#\s\{}\([^<Bar>]\{-}\)\s\+<Bar>\s\+\([^<Bar>]\{-}\)\s\+<Bar>/
  \<Bar> \2 <Bar> \1 <Bar>
  \/<CR><c-o>
  \ :call <SID>align()<CR><c-l>

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

" Tags
set tags=tags;/,libtags;/

" Color scheme
syntax on
source ~/.vim/enable16colors.vim
colorscheme jellybeans
set number
set numberwidth=5

" Error Markers
let errormarker_erroricon    = expand("~/.vim/icons/error.bmp")
let errormarker_warningicon  = expand("~/.vim/icons/warning.bmp")
let errormarker_errorgroup   = "ErrorMsg"
let errormarker_warninggroup = "WarningMsg"

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

" Config
au BufNewFile,BufRead *.cfg set filetype=config

" Gitolite
au BufNewFile,BufRead gitolite.conf,*/gitolite-admin/conf/* set filetype=gitolite
au BufNewFile,BufRead {,.}gitolite.rc,example.gitolite.rc set filetype=perl

" Javascript / JSON
au BufNewFile,BufRead *.json set filetype=javascript
au FileType javascript setlocal tabstop=2
au FileType javascript setlocal shiftwidth=2
au FileType javascript call EnableWhitespace()

" Coffeescript
au FileType coffee setlocal tabstop=2
au FileType coffee setlocal shiftwidth=2
au FileType coffee setlocal makeprg=coffee\ --compile\ --lint\ %\ $*
au FileType coffee call EnableWhitespace()

" HTML
au FileType html setlocal tabstop=2
au FileType html setlocal shiftwidth=2
au FileType html call EnableWhitespace()

" XML
au FileType xml setlocal tabstop=2
au FileType xml setlocal shiftwidth=2
au FileType xml call EnableWhitespace()

" CSS
au FileType css setlocal tabstop=2
au FileType css setlocal shiftwidth=2
au FileType css call EnableWhitespace()

" C#
au FileType cs setlocal tabstop=4
au FileType cs setlocal shiftwidth=4
au FileType cs compiler msbuild
au FileType cs call EnableWhitespace()

" Visual Studio Settings
au BufNewFile,BufRead *.vssettings set filetype=xml

" PowerShell
au BufNewFile,BufRead *.ps1 set filetype=ps1
au FileType ps1 call EnableWhitespace()

" Markdown
au FileType markdown set ai comments=n:&gt;
au FileType markdown set textwidth=72 formatoptions=tcroqn2
au FileType markdown call EnableWhitespace()

" Ruby
au BufNewFile,BufRead *.rb,*.ru,rakefile,vagrantfile set filetype=ruby
au FileType ruby setlocal tabstop=2
au FileType ruby setlocal shiftwidth=2
au FileType ruby let g:rubycomplete_buffer_loading = 1
au FileType ruby let g:rubycomplete_classes_in_global = 1
au FileType ruby let g:rubycomplete_include_object = 1
au FileType ruby let g:rubycomplete_include_objectspace = 1
au FileType ruby call EnableWhitespace()

if has("win32") || has("win64")
  let ruby_path="C:\Ruby192"
endif

" Object J
au BufNewFile,BufRead *.j set filetype=objj
au BufNewFile,BufRead *.sj set filetype=javascript

" F#
au BufNewFile,BufRead *.fs set filetype=fs

" GML
au BufNewFile,BufRead *.gml set filetype=config

" Arduino
au BufNewFile,BufRead *.pde,*.ino set filetype=arduino
au FileType arduino setlocal makeprg=make\ -C\ ./build
au FileType arduino setlocal shellpipe=>/dev/null\ 2>
au FileType arduino setlocal autoindent
au FileType arduino setlocal smartindent
au FileType arduino setlocal cindent

" C, CPP, Arduino
au FileType c,cpp,arduino setlocal path=.
au FileType c,cpp,arduino setlocal path+=/usr/include
au FileType c,cpp,arduino setlocal path+=/usr/lib/avr/include
au FileType c,cpp,arduino setlocal path+=~/arduino-1.0/hardware/arduino/cores/arduino
au FileType c,cpp,arduino setlocal path+=~/arduino-1.0/libraries/*
au FileType c,cpp,arduino setlocal path+=,
au FileType c,cpp,arduino setlocal cinoptions=(1s,u0
au FileType c,cpp,arduino syntax match cType /\<\h\w*_t\>/
au FileType c,cpp,arduino syntax match cConstant /\<[A-Z_][A-Z0-9_]*\>/
au FileType c,cpp,arduino call EnableWhitespace()

" Haskell
au BufNewFile,BufRead *.dump-cmm set filetype=c
au BufNewFile,BufRead *.hs,*.hsc,*.lhs,*.dump-simpl set filetype=haskell
au BufNewFile,BufRead *.lhs set syntax=lhaskell
au FileType haskell compiler ghcmod
if has("win32") || has("win64")
  au FileType haskell setlocal shellpipe=2>NUL\ 1>
else
  au FileType haskell setlocal shellpipe=&>
endif
au FileType haskell setlocal iskeyword+='
au FileType haskell setlocal tabstop=4
au FileType haskell setlocal shiftwidth=4
au FileType haskell setlocal path=src,,
au FileType haskell setlocal include=^import\\s*\\(qualified\\)\\?\\s*
au FileType haskell setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.hs'
au FileType haskell call EnableWhitespace()
let hs_highlight_types = 1
let hs_highlight_boolean = 1

" Haskell - hoogle word under cursor
au FileType haskell nnoremap <Leader>h :!hoogle <C-r><C-w><CR>

" Haskell - sort then align imports
au FileType haskell nnoremap <Leader>ai
    \ vip :sort r /\u.*/<CR> <Bar> :Tabularize /^import qualified\\|^import\\|^$<CR>

" Haskell Cabal
au BufNewFile,BufRead *.cabal set filetype=cabal
au FileType cabal setlocal tabstop=2
au FileType cabal setlocal shiftwidth=2
au FileType cabal call EnableWhitespace()

" Heist templates
au BufNewFile,BufRead *.tpl set filetype=html

" Alex lexer / Happy parser
au BufNewFile,BufRead *.x set filetype=alex
au FileType alex compiler ghc
au FileType alex setlocal makeprg=alex\ %\ &&\ ghc\ -e\ :q\ %:r.hs
au FileType alex call EnableWhitespace()
au BufNewFile,BufRead *.y set filetype=happy

" Google protobuf highlighiting
au! BufRead,BufNewFile *.proto setfiletype proto

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
source ~/.vim/whitespace.vim
