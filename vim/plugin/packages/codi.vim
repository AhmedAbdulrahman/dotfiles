highlight CodiVirtualText guifg='#98C379'

let g:codi#virtual_text_prefix = "❯ "

let g:codi#aliases = {
	\ 'javascript.jsx': 'javascript',
\ }

let g:codi#interpreters = {
	\ 'javascript': {
	\   'bin': 'qjs',
	\   'prompt': '^\(qjs >\|{\+  \.\.\.\)',
	\   'quitcmd': '\q',
	\   'rightalign': 0,
	\ },
	\ 'python': {
      \ 'bin': '/usr/bin/python3',
      \ 'prompt': '^\(>>>\|\.\.\.\) ',
	\ },
\}
