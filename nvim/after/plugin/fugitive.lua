if vim.fn.exists 'g:loaded_fugitive' == 0 then
  return
end

local map = require '_.utils.map'
local au = require '_.utils.au'


if vim.fn.exists 'g:fugitive_browse_handlers' == 0 then
  vim.g.fugitive_browse_handlers = {}
end

-- Define mappings.
map.nnoremap('<leader>gb', '<Cmd>Git blame<CR>', { silent = true })
map.nnoremap('<leader>gd', '<Cmd>Gdiffsplit<CR>', { silent = true })

au.augroup('__my_fugitive__', function()
  -- http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
  au.autocmd('BufReadPost', 'fugitive://*', function()
    vim.opt.bufhidden = 'delete'
  end)
  au.autocmd(
    'User',
    'fugitive',
    [[if get(b:, 'fugitive_type', '') =~# '^\%(tree\|blob\)$' | nnoremap <buffer> .. :edit %:h<CR> | endif]]
  )
end)
