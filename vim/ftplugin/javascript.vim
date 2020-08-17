" List of file extensions which are used with `gf` like commands."
setlocal suffixesadd=.js,.jsx

" Set include pattern for only ECMAScript modules."
let &l:include = '\<from\>\s["'']\zs[^"'']\+\ze["'']'

" Define 'formatprg'."
let &l:formatprg = printf(
	\ '%s --parser "babel"',
	\ !empty(glob('node_modules/prettier/bin-prettier.js'))
		\ ? 'node_modules/prettier/bin-prettier.js'
		\ : 'prettier'
\ )

" Define 'makeprg'."
let s:package_lock = findfile('package-lock.json', expand('%:p').';')

if filereadable(s:package_lock)
  setlocal makeprg=npm
else
  setlocal makeprg=yarn
endif

" Execute current file."
nnoremap <buffer><silent> <LocalLeader>r :execute 'split <Bar> terminal node' shellescape(@%, 1)<CR>
