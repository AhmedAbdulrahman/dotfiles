""
" Context-aware completion engine."
""

scriptencoding UTF-8

" Disable automatically opening quickfix list upon errors."
let g:coc_auto_copen = v:false
let g:nvim_buf_set_virtual_text = v:true

" Environment node"
let g:coc_node_path=exepath('node')
let g:node_client_debug = 1

let g:coc_filetype_map = {
	\ 'html.swig': 'html',
	\ 'wxss': 'css',
\ }

" List of extensions."
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-tag',
	\ 'coc-snippets',
	\ 'coc-stylelintplus',
	\ 'coc-tsserver',
	\ 'coc-conjure',
	\ 'coc-phpls',
	\ 'coc-python',
	\ 'coc-svg',
	\ 'coc-tsserver',
	\ 'coc-tailwindcss',
	\ 'coc-yaml',
	\ 'coc-emmet',
	\ 'coc-highlight',
\ ]

" User configuration."
let g:coc_user_config = {
	\ 'suggest': {
		\ 'maxPreviewWidth': 50,
		\ 'floatEnable': ahmed#settings#has_floating_window(),
		\ 'labelMaxLength': 200,
		\ 'detailMaxLength': 200,
		\ 'disableKind': v:true,
		\ 'disableMenu': v:true,
		\ 'disableMenuShortcut': v:true,
		\ 'snippetIndicator': ' [snippet]',
		\ 'maxCompleteItemCount': 20,
		\ 'timeout': 2000,
		\ 'noselect': v:false,
		\ 'keepCompleteopt': v:true
	\ },
	\ 'diagnostic': {
		\ 'enable': v:true,
		\ 'checkCurrentLine': v:true,
		\ 'enableHighlightLineNumber': v:false,
		\ 'messageTarget': ahmed#settings#has_floating_window() ? 'float' : 'echo',
		\ 'refreshOnInsertMode': v:true,
 		\ 'displayByAle': v:true,
		\ 'virtualText': v:true,
		\ 'virtualTextPrefix': '  ',
		\ 'enableMessage': 'never',
		\ 'errorSign': '🔥',
		\ 'warningSign': '💩',
		\ 'infoSign': '😱',
		\ 'hintSign': '🧙',
		\ 'maxWindowHeight': 5
	\ },
	\ 'signature': {
		\ 'enable': v:true,
		\ 'target': ahmed#settings#has_floating_window() ? 'float' : 'echo',
	\ },
	\ 'css': {
		\ 'validate': v:false
	\ },
	\ 'javascript': {
		\ 'validate': {
			\ 'enable': v:false
		\ },
		\ 'referencesCodeLens': {
			\ 'enable': v:false
		\ }
	\ },
	\ 'typescript': {
		\ 'referencesCodeLens': {
			\ 'enable': v:false
		\ }
	\ },
	\ 'coc': {
		\ 'preferences': {
			\ 'hoverTarget':  ahmed#settings#has_floating_window() ? 'float' : 'echo',
			\ 'colorSupport': v:true,
			\ 'enableFloatHighlight': v:false,
			\ 'bracketEnterImprove': v:false
		\ },
	\ },
	\ 'snippets': {
		\ 'priority': 200,
		\ 'shortcut': 'S',
		\ 'ultisnips': {
			\ 'enable': v:true,
			\ 'directories': ['UltiSnips']
		\ },
		\ 'extends': {
			\ "javascriptreact": ["javascript"],
			\ "typescriptreact": ["typescript"]
		\ },
	\ },
	\ 'highlight': {
		\ 'disableLanguages': '',
		\ 'document.enable': v:true,
		\ 'colors.enable': v:true
	\ },
	\ 'python': {
		\ 'jediEnabled': 0,
		\ 'linting': { 'pylintUseMinimalCheckers': 0 },
	\ },
	\ 'emmet': {
		\ 'includeLanguages': { 'javascript': 'javascriptreact' },
	\ },
	\ 'rust': {
		\ 'clippy_preference': 'on',
	\ },
	\  'json': {
		\     'schemas': [
			\       {
			\         'name': 'tsconfig.json',
			\         'description': 'TypeScript compiler configuration file',
			\         'fileMatch': ['tsconfig.json', 'tsconfig.*.json'],
			\         'url': 'http://json.schemastore.org/tsconfig'
			\       },
			\       {
			\         'name': 'tslint.json',
			\         'description': 'tslint configuration file',
			\         'fileMatch': ['tslint.json'],
			\         'url': 'http://json.schemastore.org/tslint'
			\       },
			\       {
			\         'name': 'lerna.json',
			\         'description': 'Lerna config',
			\         'fileMatch': ['lerna.json'],
			\         'url': 'http://json.schemastore.org/lerna'
			\       },
			\       {
			\         'name': '.babelrc.json',
			\         'description': 'Babel configuration',
			\         'fileMatch': ['.babelrc.json', '.babelrc', 'babel.config json'],
			\         'url': 'http://json.schemastore.org/lerna'
			\       },
			\       {
			\         'name': '.eslintrc.json',
			\         'description': 'ESLint config',
			\         'fileMatch': ['.eslintrc.json', '.eslintrc'],
			\         'url': 'http://json.schemastore.org/eslintrc'
			\       },
			\       {
			\         'name': 'bsconfig.json',
			\         'description': 'Bucklescript config',
			\         'fileMatch': ['bsconfig.json'],
			\         'url': 'https://bucklescript.github.io/bucklescript/docson/build-schema.json'
			\       },
			\       {
			\         'name': '.prettierrc',
			\         'description': 'Prettier config',
			\         'fileMatch': ['.prettierrc', '.prettierrc.json', 'prettier.config.json'],
			\         'url': 'http://json.schemastore.org/prettierrc'
			\       },
			\       {
			\         'name': 'now.json',
			\         'description': 'ZEIT Now config',
			\         'fileMatch': ['now.json'],
			\         'url': 'http://json.schemastore.org/now'
			\       },
			\       {
			\         'name': '.stylelintrc.json',
			\         'description': 'Stylelint config',
			\         'fileMatch': ['.stylelintrc', '.stylelintrc.json', 'stylelint.config.json'],
			\         'url': 'http://json.schemastore.org/stylelintrc'
			\       },
		\     ]
		\  },
\ }

" Mappings."
" rename the current word in the cursor "
nmap <Leader>rn  <Plug>(coc-rename)
nmap <Leader>cr <Plug>(coc-refactor)

" Go to definition of word under cursor "
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
" Find references "
nmap <silent> gr <Plug>(coc-references)

" Refresh completion suggestions"- new
inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> <Backspace> <Plug>(coc-range-select)
xmap <silent> <Backspace> <Plug>(coc-range-select)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" ALT-k and ALT-j to navigate errors"
if system('uname -s') == "Darwin\n"
  "OSX"
  nmap <silent> <M-k> <Plug>(coc-diagnostic-prev)
  nmap <silent> <M-j> <Plug>(coc-diagnostic-next)
else
  "Linux"
  nmap <silent> <A-k> <Plug>(coc-diagnostic-prev)
  nmap <silent> <A-j> <Plug>(coc-diagnostic-next)
endif

" Use K to show documentation in preview window."
nnoremap <silent> K :call <SID>show_documentation()<CR>

" show commit contains current position"
nmap <silent> gc <Plug>(coc-git-commit)

nmap <C-p> <Plug>(coc-format)

augroup cocsettings
	autocmd!
	" Setup formatexpr specified filetype(s)."
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

	" Update signature help on jump placeholder"
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

	" Highlight symbol under cursor on CursorHold"
	autocmd CursorHold * silent call CocActionAsync('highlight')

	autocmd BufWritePost coc.vim source % | CocRestart
	autocmd BufWritePost {coc-settings,tsconfig}.json,.flowconfig CocRestart
	autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport'
augroup end
