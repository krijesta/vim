" Highlights all tabs and spaces on lines that the cursor isn't at the end of
" Better than the simple regex as it shouldn't flash bad while typing/going to
" a new line.

function! ToggleShowWhitespace()
  if !exists('b:ws_show')
    let b:ws_show = 0
  endif
  let b:ws_show = !b:ws_show
  if b:ws_show
    syntax match ExtraWhitespace /\v(\t|\s+%#@<!$)/ containedin=ALL
  else
    syntax clear ExtraWhitespace
  endif
endfunction

function! EnableWhitespace()
  let b:ws_show=0
  call ToggleShowWhitespace()
endfunction

nnoremap <Leader>ws :call ToggleShowWhitespace()<CR>
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
