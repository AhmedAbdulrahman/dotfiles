""
" Context-aware completion engine."
""

scriptencoding UTF-8

if !exists('g:did_coc_loaded')
  finish
endif

let g:coc_node_path=exepath('node')

" Disable automatically opening quickfix list upon errors."
let g:coc_auto_copen = v:false

" List of extensions."
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-highlight',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-snippets',
	\ 'coc-stylelint',
	\ 'coc-tag',
	\ 'coc-tsserver',
    \ 'coc-rls',
    \ 'coc-python',
    \ 'coc-yaml',
    \ 'coc-emoji',
    \ 'coc-ultisnips',
    \ 'coc-phpls',
    \ 'coc-vimlsp',
    \ 'coc-github',
    \ 'coc-git'
\ ]

let s:LSP_CONFIG = [
      \ ['flow', {
      \   'command': exepath('flow'),
      \   'args': ['lsp'],
      \   'filetypes': ['javascript', 'javascript.jsx'],
      \   'initializationOptions': {},
      \   'requireRootPattern': 1,
      \   'settings': {},
      \   'rootPatterns': ['.flowconfig']
      \ }],
      \ ['ocaml', {
      \   'command': exepath('ocaml-language-server'),
      \   'args': ['--stdio'],
      \   'filetypes': ['ocaml', 'reason']
      \ }],
      \ ['bash', {
      \   'command': exepath('bash-language-server'),
      \   'args': ['start'],
      \   'filetypes': ['sh', 'bash'],
      \   'ignoredRootPaths': ['~']
      \ }],
      \ ['docker', {
      \   'command': exepath('docker-langserver'),
      \   'args': ['--stdio'],
      \   'filetypes': ['dockerfile']
      \ }],
      \ ['clojure', {
      \   'command': exepath('clojure-lsp'),
      \   'filetypes': ['clojure']
      \  }],
      \ ['golang', {
      \   'command': exepath('gopls'),
      \   'filetypes': ['go'],
      \   'rootPatterns': ['go.mod', '.vim/', '.git/', '.hg/']
      \  }],
      \ ]

" User configuration."
call coc#config('suggest', {
      \ 'autoTrigger': 'always',
      \ 'noselect': 0,
      \ 'echodocSupport': 1
      \ })
call coc#config('diagnostic', {
      \ 'errorSign': '×',
      \ 'warningSign': '●',
      \ 'infoSign': '!',
      \ 'hintSign': '!',
      \ 'displayByAle': functions#has_floating_window() ? 0 : 1,
      \ 'refreshOnInsertMode': 1
      \ })

call coc#config('coc.preferences', {
      \ 'colorSupport': 0,
      \ 'hoverTarget': functions#has_floating_window() ? 'float' : 'echo',
      \ 'signatureHelpTarget': functions#has_floating_window() ? 'float' : 'echo',
      \ })

call coc#config('python', {
      \ 'linting': {
      \   'pylintUseMinimalCheckers': 0
      \   }
      \ })

call coc#config('git', {
      \ 'enableGutters': 1,
      \ 'addedSign.text':'▎',
      \ 'changedSign.text':'▎',
      \ 'removedSign.text':'◢',
      \ 'topRemovedSign.text': '◥',
      \ 'changeRemovedSign.text': '◢',
      \ })

call coc#config('coc.github', {
      \ 'filetypes': ['gitcommit', 'markdown.ghpull']
      \ })

let s:languageservers = {}
for [lsp, config] in s:LSP_CONFIG
  " COC chokes on emptykcommands https://github.com/neoclide/coc.nvim/issues/418#issuecomment-462106680"
  let s:not_empty_cmd = !empty(get(config, 'command'))
  if s:not_empty_cmd | let s:languageservers[lsp] = config | endif

  " Disable tsserver when flow is loaded
  if lsp ==# 'flow' && s:not_empty_cmd | call coc#config('tsserver', { 'enable': 0 }) | endif
endfor

if !empty(s:languageservers)
  call coc#config('languageserver', s:languageservers)
endif

