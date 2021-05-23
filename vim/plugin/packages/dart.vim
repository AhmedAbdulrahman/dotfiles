""
" Dart."
""

let g:dart_format_on_save = 1
let g:dartfmt_options = ['--fix', '--line-length 120']

nnoremap <leader>fe :CocCommand flutter.emulators <CR>
nnoremap <leader>fd :below new output:///flutter-dev <CR>
