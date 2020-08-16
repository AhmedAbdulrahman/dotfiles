" Run any command under toggle terminal."
command -nargs=* -complete=shellcmd T call ahmed#terminal#execute(<q-args>)

" Start profiling until it's invoked with ! modifier once again."
command -bang Profile call ahmed#commands#profile#(<bang>v:false)

" Display the contents of all registers in vertical split like `:registers`."
command Registers call ahmed#commands#registers#()

" Search text in git repository or current working directory."
command -nargs=1 -bang Search call ahmed#commands#search#(<bang>v:false, <args>)

" Preview Markdown files."
command! -nargs=* -complete=file Preview call ahmed#commands#preview#(<f-args>)

" ALE quick command to toggle fixing"
command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"

" Pick color (only works on Mac or have python gtk module installed)"
command! -nargs=0 PickColor :call CocAction('pickColor')

" Pick a different color presentation of color"
command! -nargs=0 Presentation :call CocAction('colorPresentation')
