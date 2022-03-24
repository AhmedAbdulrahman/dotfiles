""
" Move Selected lines in Visual Mode"
""
"xnoremap <silent> K :call mappings#visual#movelines#moveup()<CR>"
"xnoremap <silent> J :call mappings#visual#movelines#movedown()<CR>"
""
function! s:Visual()
    return visualmode() == 'V'
endfunction

function! s:GetMove(address, should_move)
  if s:Visual() && a:should_move
    execute "'<,'>move " . a:address
    call feedkeys('gv=', 'n')
  endif
  call feedkeys('gv', 'n')
endfunction

function! mappings#visual#movelines#moveup() abort range
  let l:count=v:count ? -v:count : -1
  let l:max=(a:firstline - 1) * -1
  let l:movement=max([l:count, l:max])
  let l:address="'<" . (l:movement - 1)
  let l:should_move=l:movement < 0
  call s:GetMove(l:address, l:should_move)
endfunction

function! mappings#visual#movelines#movedown() abort range
  let l:count=v:count ? v:count : 1
  let l:max=line('$') - a:lastline
  let l:movement=min([l:count, l:max])
  let l:address="'>+" . l:movement
  let l:should_move=l:movement > 0
  call s:GetMove(l:address, l:should_move)
endfunction
