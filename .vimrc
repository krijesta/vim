set nocompatible " use vim settings (rather than vi)

set backspace=indent,eol,start " allow backspace over everthing
set nobackup                   " do not keep backup file
set history=50                 " keep 50 lines of command history
set ruler                      " show cursor position
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching

" search highlighting toggle
nnoremap <F10> :set hls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>
nnoremap <F11> :nohls<CR>
set hls " search highlighting on by default

" cycling through buffers
nnoremap <A-Right> :bnext<CR>
nnoremap <A-Left> :bprevious<CR>
set hidden " don't discard buffer when switching away

" replace word under cursor
" usage: type \s on "foo" and then type "bar/g" to
"        replace foo with bar
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" code indenting and formatting
filetype plugin on
filetype indent on
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set foldmethod=marker

" window size
"winpos 20 20
"set lines=24
"set columns=80

" Toggle insert mode
"map! ii <Esc>

" font and color scheme
syntax on
set guifont=Monospace\ 14
exe "source ~/.vim/themes/enable16colors.vim"
exe "source ~/.vim/themes/jake.vim"
