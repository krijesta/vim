set nocompatible " use vim settings (rather than vi)

set hidden                     " don't discard buffer when switching away
set backspace=indent,eol,start " allow backspace over everthing
set nobackup                   " do not keep backup file
set history=50                 " keep 50 lines of command history
set ruler                      " show cursor position
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching
set lines=24 columns=85

command! W :w " allow saving via :W
let mapleader = ","

" Compatibility with different operating systems
if has("win32") || has("win64")
  let g:vimdir = "~/vimfiles/"
else
  let g:vimdir = "~/.vim/"
endif
let g:vimrc = g:vimdir . "vimrc"

" Edit .vimrc
nmap <leader>v :exec ":tabedit " . g:vimrc<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd! BufWritePost vimrc exec "source " . g:vimrc
endif

" Swap current character with next
nnoremap <silent> gc xph
" Swap current word with next
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

" Search highlighting toggle
nnoremap <F11> :set hlsearch! hlsearch?<CR>
nnoremap <A-S-F11> :set hls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set nohls " search highlighting on by default

" Cycling through buffers
nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprevious<CR>
nnoremap <C-l> :bdelete<CR>
nnoremap <D-j> :tabnext<CR>
nnoremap <D-k> :tabprevious<CR>

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
let g:netrw_liststyle    = 3 " Use tree-mode as default view
let g:netrw_browse_split = 4 " Open file in previous buffer
let g:netrw_preview      = 1 " preview window shown in a vertically split

" Code indenting and formatting
filetype plugin on
filetype indent on
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set foldmethod=marker

" Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" Ctags
set tags=tags;/

function! Load(relative_path)
  exec "source " . g:vimdir . a:relative_path
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
au FileType vim setlocal tabstop=2
au FileType vim setlocal shiftwidth=2

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
au FileType html call EnableWhitespace('et')

" CSS
au FileType css setlocal tabstop=2
au FileType css setlocal shiftwidth=2
au FileType css call EnableWhitespace('et')

" C#
au FileType cs setlocal tabstop=4
au FileType cs setlocal shiftwidth=4
au FileType cs setlocal expandtab
au FileType cs compiler msbuild
au FileType cs call EnableWhitespace('et')

" Visual Studio Settings
au BufNewFile,BufRead *.vssettings set filetype=xml

" Markdown
au BufNewFile,BufRead *.mkd,*.md set filetype=mkd
au BufRead *.mkd,*.md set ai formatoptions=tcroqn2 comments=n:&gt;

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
au FileType arduino set autoindent
au FileType arduino set smartindent
au FileType arduino set cindent

" Haskell
au BufNewFile,BufRead *.hs,*.hsc,*.lhs set filetype=haskell
au BufNewFile,BufRead *.lhs set syntax=lhaskell
au FileType haskell compiler ghc
au FileType haskell setlocal tabstop=4
au FileType haskell setlocal shiftwidth=4
au FileType haskell call EnableWhitespace('et')
let hs_highlight_types = 1
let hs_highlight_boolean = 1

" Haskell Cabal
au BufNewFile,BufRead *.cabal set filetype=cabal
au FileType cabal setlocal tabstop=2
au FileType cabal setlocal shiftwidth=2
au FileType cabal call EnableWhitespace('et')

" Heist templates
au BufNewFile,BufRead *.tpl set filetype=html

" Alex lexer / Happy parser
au BufNewFile,BufRead *.x set filetype=alex
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
