local map = require '_.utils.map'

-- Comment and uncomment operator.
map.nnoremap('gc', '<Cmd>set operatorfunc=ahmed#mappings#operator#comment#<CR>g@', {
	silent = true,
})

map.xnoremap('gc', ':<C-u>call ahmed#mappings#operator#comment#(visualmode())<CR>', {
	silent = true,
})
