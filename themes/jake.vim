" Jacob's Vim Theme 
" ------------------
" Filename: jacob.vim
" Author:   Jacob Stanley
" Contents: Colours and Fonts

set bg=dark
hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "jacob"

hi Normal       guifg=#c0c0c0 guibg=#000030                           ctermfg=gray        ctermbg=black
hi ErrorMsg     guifg=#ffffff guibg=#287eff                           ctermfg=white       ctermbg=lightblue
hi Visual       guifg=#8080ff guibg=fg          gui=reverse           ctermfg=lightblue   ctermbg=fg        cterm=reverse
hi VisualNOS    guifg=#8080ff guibg=fg          gui=reverse,underline ctermfg=lightblue   ctermbg=fg        cterm=reverse,underline
hi Todo         guifg=#d14a14 guibg=#1248d1                           ctermfg=red         ctermbg=darkblue
hi Search       guifg=#90fff0 guibg=#2050d0                           ctermfg=white       ctermbg=darkblue  cterm=underline         term=underline
hi IncSearch    guifg=#b0ffff guibg=#2050d0                           ctermfg=darkblue    ctermbg=gray

hi SpecialKey   guifg=cyan                                            ctermfg=darkcyan
hi Directory    guifg=cyan                                            ctermfg=cyan
hi Title        guifg=magenta                   gui=none              ctermfg=magenta                       cterm=bold
hi WarningMsg   guifg=red                                             ctermfg=red
hi WildMenu     guifg=yellow  guibg=black                             ctermfg=yellow      ctermbg=black     cterm=none              term=none
hi ModeMsg      guifg=#22cce2                                         ctermfg=lightblue
hi MoreMsg                                                            ctermfg=darkgreen   ctermfg=darkgreen
hi Question     guifg=#78d520                   gui=none              ctermfg=green                         cterm=none
hi NonText      guifg=#0030ff                                         ctermfg=darkblue

hi StatusLine   guifg=blue    guibg=darkgray    gui=none              ctermfg=blue        ctermbg=gray      cterm=none              term=none
hi StatusLineNC guifg=black   guibg=darkgray    gui=none              ctermfg=black       ctermbg=gray      cterm=none              term=none
hi VertSplit    guifg=black   guibg=darkgray    gui=none              ctermfg=black       ctermbg=gray      cterm=none              term=none

hi Folded       guifg=#808080 guibg=#000040                           ctermfg=darkgrey    ctermbg=black     cterm=bold              term=bold
hi FoldColumn   guifg=#808080 guibg=#000040                           ctermfg=darkgrey    ctermbg=black     cterm=bold              term=bold
hi LineNr       guifg=#90f020                                         ctermfg=green                         cterm=none

hi DiffAdd                    guibg=darkblue                                              ctermbg=darkblue  cterm=none              term=none
hi DiffChange                 guibg=darkmagenta                                           ctermbg=magenta   cterm=none
hi DiffDelete   guifg=Blue    guibg=DarkCyan    gui=bold              ctermfg=blue        ctermbg=cyan
hi DiffText                   guibg=Red         gui=bold                                  ctermbg=red       cterm=bold

hi Cursor       guifg=#000020 guibg=#ffaf38                           ctermfg=bg          ctermbg=brown
hi lCursor      guifg=#ffffff guibg=#000000                           ctermfg=bg          ctermbg=darkgreen

hi Comment      guifg=#80a0ff                                         ctermfg=blue                          cterm=none
hi Constant     guifg=#ef4848                                         ctermfg=lightred                      cterm=none
hi Special      guifg=orange                    gui=none              ctermfg=brown                         cterm=none
hi Identifier   guifg=#38d6c2                                         ctermfg=cyan                          cterm=none
hi Statement    guifg=#e3c22d                   gui=none              ctermfg=yellow                        cterm=none 
hi PreProc      guifg=#c44db7                   gui=none              ctermfg=magenta                       cterm=none
hi type         guifg=#78d520                   gui=none              ctermfg=green                         cterm=none
hi Underlined                                                                                               cterm=underline         term=underline
hi Ignore       guifg=bg                                              ctermfg=bg
