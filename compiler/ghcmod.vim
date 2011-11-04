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
setlocal makeprg=(ghc-mod\ check\ %\ &\ ghc-mod\ lint\ %)\ \\\|\ tr\ '\\000'\ '\\n'

" quickfix mode: 
" fetch file/line-info from error messages
setlocal errorformat=
      \%-G\\s%#,
      \%E%f:%l:%c:\ Error:\ %m,
      \%W%f:%l:%c:\ Warning:\ %m,
      \%E%f:%l:%c:%m,
      \%m
