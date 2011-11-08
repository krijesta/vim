" Vim Compiler File
" Compiler:	ghcmod
" Maintainer: Jacob Stanley

if exists("current_compiler") && current_compiler == "ghcmod"
  finish
endif
let current_compiler = "ghcmod"

let s:scriptname = "ghcmod.vim"

if !executable('ghc-mod')
  echoerr s:scriptname.": can't find ghc-mod, make sure it is in the PATH"
  finish
endif

" set makeprg (for quickfix mode) 
let path = shellescape(expand('%'))
let check_then_lint = '(ghc-mod\ check\ '.path.'\ &\ ghc-mod\ lint\ '.path.')\ \\\|\ tr\ ''\\000''\ ''\\n'''

" In order to pass a pipe (|) windows needs the whole command to be quoted.
" If we quote the whole command under posix it is interpreted as looking for a
" file with that name.
if has("win32") || has("win64")
exec "setlocal makeprg=\\\"".check_then_lint."\\\""
else
exec "setlocal makeprg=".check_then_lint
endif

" quickfix mode: 
" fetch file/line-info from error messages
setlocal errorformat=
      \%-G\\s%#,
      \%W%f:%l:%c:\ Warning:\ %m,
      \%W%f:%l:%c:Warning:\ %m,
      \%E%f:%l:%c:\ Error:\ %m,
      \%E%f:%l:%c:%m,
      \%m
