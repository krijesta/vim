" Check that we don't already have support for more than
" 16 colors, otherwise we're making things worse :)
if &t_Co > 16
  finish
endif

" Vim defaults to only 8 colors in some cases, but even
" Windows terminals have support for 16 colors, so lets
" make we use them. We also need to set the background
" and foreground color, because the defaults aren't great.
if has("terminfo")
  set t_Co=16
  set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm " background color
  set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm " foreground color
else
  set t_Co=16
  set t_Sb=[4%dm " background color
  set t_Sf=[3%dm " foreground color
endif
