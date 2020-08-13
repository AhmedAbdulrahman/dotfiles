function! ahmed#pinnacle#active() abort
  try
    call pinnacle#highlight({})
    return 1
  catch /E117/
    " Pinnacle probably isn't loaded"
    return 0
  endtry
endfunction
