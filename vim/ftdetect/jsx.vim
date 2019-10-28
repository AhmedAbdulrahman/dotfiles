" Set 'filetype' to 'javascript.jsx' if file contains 'import React'."
autocmd BufNewFile,BufRead *.js,*.jsx,*.tsx
	\ if ahmed#ftdetect#contains('\v\C^import\sReact', { 'maxline': 20 }) |
		\ set filetype=javascript.jsx |
	\ endif
