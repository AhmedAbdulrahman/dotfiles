local au = require('_.utils.au')

au.augroup('__MyTerm__', function()
  au.autocmd('TermOpen', '*', 'setl nonumber norelativenumber')
  au.autocmd('TermOpen', 'term://*', 'startinsert')
  au.autocmd('TermClose', 'term://*', 'stopinsert')
end)
