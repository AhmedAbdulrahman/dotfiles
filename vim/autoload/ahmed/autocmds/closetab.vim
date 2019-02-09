""
" Close Open Tab with CMD-W" 
"
" Since I know it from Chrome / VSCode (cmd+w)"
function! ahmed#autocmds#closetab#()
    if (len(getbufinfo({'buflisted': 1})) > 1)
        bdelete
    endif
endfunction