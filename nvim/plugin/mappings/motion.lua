local map = require '_.utils.map'

-- [i]nner and [a]round line motions.
map.onoremap('i_', ':<C-u>normal! ^vg_<CR>')
map.xnoremap('i_', ':<C-u>normal! ^vg_<CR>')
map.onoremap('a_', ':<C-u>normal! 0v$<CR>')
map.xnoremap('a_', ':<C-u>normal! 0v$<CR>')

-- [i]n and [a]round [i]ndent motions.
map.onoremap('ii', ":<C-u>call ahmed#mappings#motion#indent#({ 'mode': 'i' })<CR>", {
	silent = true,
  })
map.xnoremap('ii', ":<C-u>call ahmed#mappings#motion#indent#({ 'mode': 'i' })<CR>", {
	silent = true,
})
map.onoremap('ai', ":<C-u>call ahmed#mappings#motion#indent#({ 'mode': 'a' })<CR>", {
	silent = true,
})
map.xnoremap('ai', ":<C-u>call ahmed#mappings#motion#indent#({ 'mode': 'a' })<CR>", {
	silent = true,
})
map.onoremap('io', ":<C-u>call ahmed#mappings#motion#indent#({ 'mode': 'o' })<CR>", {
	silent = true,
})
map.xnoremap('io', ":<C-u>call ahmed#mappings#motion#indent#({ 'mode': 'o' })<CR>", {
	silent = true,
})
