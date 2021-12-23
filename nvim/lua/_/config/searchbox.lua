-- luacheck: max line length 150

return function()
  local map = require('_.utils.map')
  local opts = { noremap = true, silent = true }

  map.nnoremap(
    '<leader>sh',
    "<cmd>lua require('searchbox').replace({confirm = 'menu'})<CR>",
    opts
  )
  map.vnoremap(
    '<leader>sh',
    "<cmd>lua require('searchbox').replace({confirm = 'menu'})<CR>",
    opts
  )
  map.nmap(
    '<leader>sc',
    "<cmd>lua require('searchbox').match_all({clear_matches = true})<CR>",
    opts
  )
  map.vnoremap(
    '<leader>se',
    "<Esc><cmd>lua require('searchbox').replace({exact = true, visual_mode = true, confirm = 'menu'})<CR>",
    opts
  )

  require('searchbox').setup({
    popup = {
      relative = 'win',
      position = {
        row = '5%',
        col = '95%',
      },
      size = 30,
      border = {
        style = 'rounded',
        highlight = 'FloatBorder',
        text = {
          top = ' Search ',
          top_align = 'left',
        },
      },
      win_options = {
        winhighlight = 'Normal:Normal',
      },
    },
  })
end
