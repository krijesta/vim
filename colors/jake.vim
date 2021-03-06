" Jake's Vim Theme 
" ------------------
" Filename: jake.vim
" Author:   Jacob Stanley
" Contents: Colours and Fonts

set bg=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "jake"

hi Normal    guifg=#c0c0c0 guibg=#000030                  ctermfg=gray      ctermbg=black
hi ErrorMsg  guifg=#ffffff guibg=#287eff                  ctermfg=white     ctermbg=lightblue
hi Visual    guifg=#004FB5 guibg=fg gui=reverse           ctermfg=darkblue  ctermbg=fg cterm=reverse
hi VisualNOS guifg=#004FB5 guibg=fg gui=reverse,underline ctermfg=darkblue  ctermbg=fg cterm=reverse,underline
hi Todo      guifg=#d14a14 guibg=#1248d1                  ctermfg=red       ctermbg=darkblue
hi Search    guifg=#90fff0 guibg=#2050d0                  ctermfg=white     ctermbg=darkblue cterm=underline term=underline
hi IncSearch guifg=#b0ffff guibg=#2050d0                  ctermfg=darkblue  ctermbg=gray
hi MatchParen guifg=#ec1f75 guibg=#170337 gui=bold

hi Comment    guifg=#808080          ctermfg=darkgray cterm=none
hi Constant   guifg=#ef4848          ctermfg=lightred cterm=none
hi Special    guifg=orange  gui=none ctermfg=brown    cterm=none
hi Identifier guifg=#1e79db          ctermfg=blue     cterm=none
hi Statement  guifg=#e3c22d gui=none ctermfg=yellow   cterm=none 
hi PreProc    guifg=#c44db7 gui=none ctermfg=magenta  cterm=none
hi Type       guifg=#78d520 gui=none ctermfg=green    cterm=none
hi Underlined                                         cterm=underline term=underline
hi Ignore     guifg=bg               ctermfg=bg

hi Pmenu    guifg=#FFCAF0 guibg=#9C5B8A
hi PmenuSel guifg=#e0e0e0 guibg=#B80083

hi SpecialKey guifg=cyan                ctermfg=darkcyan
hi Directory  guifg=cyan                ctermfg=cyan
hi Title      guifg=magenta gui=none    ctermfg=magenta                 cterm=bold
hi WarningMsg guifg=red                 ctermfg=red
hi WildMenu   guifg=yellow  guibg=black ctermfg=yellow    ctermbg=black cterm=none term=none
hi ModeMsg    guifg=#22cce2             ctermfg=lightblue
hi MoreMsg                              ctermfg=darkgreen ctermfg=darkgreen
hi Question   guifg=#78d520 gui=none    ctermfg=green                   cterm=none
hi NonText    guifg=#0030ff             ctermfg=darkblue

hi StatusLine   guifg=blue  guibg=darkgray gui=none ctermfg=blue  ctermbg=gray cterm=none term=none
hi StatusLineNC guifg=black guibg=darkgray gui=none ctermfg=black ctermbg=gray cterm=none term=none
hi VertSplit    guifg=black guibg=darkgray gui=none ctermfg=black ctermbg=gray cterm=none term=none

hi Folded     guifg=#808080 guibg=#000040 ctermfg=darkgrey ctermbg=black cterm=bold term=bold
hi FoldColumn guifg=#808080 guibg=#000040 ctermfg=darkgrey ctermbg=black cterm=bold term=bold
hi LineNr     guifg=#90f020               ctermfg=green                  cterm=none

hi DiffText   gui=bold guibg=#442266
hi DiffAdd    guibg=#000055
hi DiffChange guibg=#220044
hi DiffDelete gui=bold guifg=#604060 guibg=#302030

hi Cursor  guifg=#000020 guibg=#ffaf38 ctermfg=bg ctermbg=brown
hi lCursor guifg=#ffffff guibg=#000000 ctermfg=bg ctermbg=darkgreen
