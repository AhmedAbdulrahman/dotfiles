""
" Auto-pair plugin that supports multi-character pairs and intelligent matching."
""

" Define pairs."
let g:pear_tree_pairs = {
	\ '(': { 'closer': ')' },
	\ '[': { 'closer': ']' },
	\ '{': { 'closer': '}' },
	\ "'": { 'closer': "'" },
	\ '"': { 'closer': '"' },
	\ '<': { 'closer': '>' }
\ }

" Define filetypes should be disabled."
let g:pear_tree_ft_disabled = []

" Map <BS>, <CR>, <Esc> in insert mode."
let g:pear_tree_map_special_keys = v:true

" Maintain pair balance when typing an opening and closing character."
let g:pear_tree_smart_openers = v:true
let g:pear_tree_smart_closers = v:true

" Maintain pair balance instead of always deleting empty pairs."
let g:pear_tree_smart_backspace = v:true

" Disable dot-repeatable functionality in favor of consistent behaviour."
let g:pear_tree_repeatable_expand = v:false

" Set a timeout for the balance-checking functions used for smart pairs."
let g:pear_tree_timeout = 60

" Workaround for disabling default <Enter> mapping."
imap <C-M-S-F12> <Plug>(PearTreeExpand)
