if vim.fn.exists('g:loaded_fugitive') == 0 then
  return
end

local map = require('_.utils.map')
local au = require('_.utils.au')

if vim.fn.exists('g:fugitive_browse_handlers') == 0 then
  vim.g.fugitive_browse_handlers = {}
end

-- Define mappings.
map.nnoremap('gB', '<Cmd>Git blame<CR>', { silent = true })
map.nnoremap('gd', '<Cmd>Gdiffsplit<CR>', { silent = true })
-- Open current file on github.com
map.nnoremap('gb', ':GBrowse<cr>', { silent = true })
map.vnoremap('gb', ':GBrowse<cr>', { silent = true })
-- Git status
map.nnoremap('gs', ':Git<cr>', { silent = true })
map.vnoremap('gs', ':Git<cr>', { silent = true })

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
