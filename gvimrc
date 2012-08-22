set lines=999 columns=120

" Font
if has("win32") || has("win64")
  set guifont=DejaVu_Sans_Mono:h14:cANSI
elseif has("gui_mac") || has("gui_macvim")
  set guifont=Inconsolata:h18,Menlo:h18
else
  set guifont=Monospace\ 15
endif

" Hide toolbar and scrollbars
set guioptions-=T
set guioptions-=r
set guioptions-=L

