""
" Show Git diff in the sign column."
""

scriptencoding UTF-8

" Only support git version system."
let g:signify_vcs_list = ['git']

" Disable showing counts next to signs."
let g:signify_sign_show_count = v:false

" Define symbols for signs."
let g:signify_sign_add = '+'
let g:signify_sign_delete = '-'
let g:signify_sign_delete_first_line = '◥'
let g:signify_sign_change = '>'
let g:signify_sign_changedelete = '◢'

" [i]n [c]hunk and [a] [c]hunk motions."
omap ic <Plug>(signify-motion-inner-pending)
xmap ic <Plug>(signify-motion-inner-visual)
omap ac <Plug>(signify-motion-outer-pending)
xmap ac <Plug>(signify-motion-outer-visual)
