" [a]n and [i]n [e]ntire buffer motions."
onoremap <silent> ae :<C-u>call ahmed#mappings#motion#entire#()<CR>
xnoremap <silent> ae :<C-u>call ahmed#mappings#motion#entire#()<CR>

" [i]nner and [a]round line motions."
onoremap <silent> i_ :<C-u>normal! ^vg_<CR>
xnoremap <silent> i_ :<C-u>normal! ^vg_<CR>
onoremap <silent> a_ :<C-u>normal! 0v$<CR>
xnoremap <silent> a_ :<C-u>normal! 0v$<CR>

" Last selected area motion."
onoremap gv :<C-u>normal! gv<CR>

" [i]n and [a]round [i]ndent motions."
onoremap <silent> ii :<C-u>call ahmed#mappings#motion#indent#({ 'mode': 'i' })<CR>
xnoremap <silent> ii :<C-u>call ahmed#mappings#motion#indent#({ 'mode': 'i' })<CR>
onoremap <silent> ai :<C-u>call ahmed#mappings#motion#indent#({ 'mode': 'a' })<CR>
xnoremap <silent> ai :<C-u>call ahmed#mappings#motion#indent#({ 'mode': 'a' })<CR>
onoremap <silent> io :<C-u>call ahmed#mappings#motion#indent#({ 'mode': 'o' })<CR>
xnoremap <silent> io :<C-u>call ahmed#mappings#motion#indent#({ 'mode': 'o' })<CR>
