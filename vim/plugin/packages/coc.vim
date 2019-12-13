""
" Context-aware completion engine."
""

scriptencoding UTF-8

" Disable automatically opening quickfix list upon errors."
let g:coc_auto_copen = v:false

" List of extensions."
let g:coc_extension_root = $VIMHOME . '/coc/extensions'

" Environment node"
let g:coc_node_path=exepath('node')

" Use <C-j> for jump to next placeholder, it's default of coc.nvim"
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim"
let g:coc_snippet_prev = '<c-k>'

" Language servers Config."
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
	\   'filetypes': ['Dockerfile', 'dockerfile']
	\ }],
	\ ['golang', {
	\   'command': exepath('gopls'),
	\   'rootPatterns': ['go.mod', '.vim/', '.git/', '.hg/'],
	\   'filetypes': ['go'],
	\   'initializationOptions': {
	\     'usePlaceholders': 1
	\   }
	\  }],
	\ ['haskell', {
	\    'command': exepath('hie-wrapper'),
	\    'filetypes': ['hs', 'lhs', 'haskell'],
	\    'rootPatterns': ['stack.yaml', 'cabal.config', 'package.yaml'],
	\    'settings': {
	\      'languageServerHaskell': {
	\        'hlintOn': empty(exepath('hlint')) ? 1 : 0,
	\      }
	\    }
	\  }],
	\ ['elm', {
	\    'command': exepath('elm-language-server'),
	\    'filetypes': ['elm'],
	\    'rootPatterns': ['elm.json'],
	\    'initializationOptions': { 'elmAnalyseTrigger': 'change' },
	\  }],
\]

let g:coc_filetype_map = {
	\ 'html.twig': 'html',
\ }

" User configuration "
let g:coc_user_config = {
	\ 'suggest': {
		\ 'maxPreviewWidth': 50,
		\ 'enablePreview': v:false,
		\ 'floatEnable': ahmed#settings#has_floating_window(),
		\ 'labelMaxLength': 200,
		\ 'detailMaxLength': 200,
		\ 'detailField': 'menu',
		\ 'autoTrigger': 'always',
		\ 'languageSourcePriority': 99,
		\ 'numberSelect': v:false,
		\ 'disableKind': v:true,
		\ 'disableMenu': v:true,
		\ 'disableMenuShortcut': v:true,
		\ 'snippetIndicator': ' [snippet]',
		\ 'maxCompleteItemCount': 20,
		\ 'preferCompleteThanJumpPlaceholder': v:false,
		\ 'fixInsertedWord': v:true,
		\ 'localityBonus': v:true,
		\ 'triggerAfterInsertEnter': v:false,
		\ 'timeout': 2000,
		\ 'minTriggerInputLength': 1,
		\ 'triggerCompletionWait': 60,
		\ 'echodocSupport': v:false,
		\ 'acceptSuggestionOnCommitCharacter': v:false,
		\ 'noselect': v:false,
		\ 'keepCompleteopt': v:true,
		\ 'completionItemKindLabels': {}
	\ },
	\ 'diagnostic': {
		\ 'enable': v:true,
		\ 'level': 'hint',
		\ 'checkCurrentLine': v:false,
		\ 'messageTarget': ahmed#settings#has_floating_window() ? 'float' : 'echo',
		\ 'joinMessageLines': v:false,
		\ 'refreshOnInsertMode': v:true,
		\ 'refreshAfterSave': v:false,
		\ 'displayByAle': v:true,
		\ 'virtualText': v:true,
		\ 'virtualTextPrefix': '  ',
		\ 'virtualTextLines': 3,
		\ 'virtualTextLineSeparator': ' \\ ',
		\ 'enableSign': v:true,
		\ 'enableMessage': 'never',
		\ 'locationlist': v:true,
		\ 'highlightOffset': 1000,
		\ 'signOffset': 1000,
		\ 'errorSign': '•',
		\ 'warningSign': '•',
		\ 'infoSign': '•',
		\ 'hintSign': '•',
		\ 'maxWindowHeight': 5
	\ },
	\ 'signature': {
		\ 'enable': v:true,
		\ 'triggerSignatureWait': 50,
		\ 'target': ahmed#settings#has_floating_window() ? 'float' : 'echo',
		\ 'floatTimeout': 1000,
		\ 'preferShownAbove': v:true,
		\ 'hideOnTextChange': v:false,
		\ 'maxWindowHeight': 8
	\ },
	\ 'codeLens': {
		\ 'enable': v:false,
		\ 'separator': ''
	\ },
	\ 'workspace': {
		\ 'ignoredFiletypes': ['markdown', 'log', 'txt', 'help']
	\ },
	\ 'list': {
		\ 'indicator': '>',
		\ 'maxHeight': 10,
		\ 'signOffset': 900,
		\ 'selectedSignText': '*',
		\ 'extendedSearchMode': v:true,
		\ 'autoResize': v:true,
		\ 'limitLines': 30000,
		\ 'maxPreviewHeight': 12,
		\ 'previewSplitRight': v:false,
		\ 'previewHighlightGroup': 'Search',
		\ 'nextKeymap': '<NOP>',
		\ 'previousKeymap': '<NOP>',
		\ 'normalMappings': {},
		\ 'insertMappings': {}
	\ },
	\ 'coc': {
		\ 'preferences': {
			\ 'useQuickfixForLocations': v:false,
			\ 'extensionUpdateCheck': 'daily',
			\ 'snippetStatusText': 'SNIP',
			\ 'hoverTarget':  ahmed#settings#has_floating_window() ? 'float' : 'echo',
			\ 'colorSupport': v:false,
			\ 'previewAutoClose': v:true,
			\ 'currentFunctionSymbolAutoUpdate': v:false,
			\ 'formatOnSaveFiletypes': [],
			\ 'enableFloatHighlight': v:false,
			\ 'rootPatterns': ['.vim', '.git'],
			\ 'watchmanPath': v:null,
			\ 'jumpCommand': 'edit',
			\ 'messageLevel': 'more',
			\ 'bracketEnterImprove': v:true,
			\ 'formatOnType': v:false,
			\ 'snippets.enable': v:true
		\ },
		\ 'source': {
			\ 'around': {
				\ 'enable': v:true,
				\ 'firstMatch': v:true,
				\ 'shortcut': 'A',
				\ 'priority': 1,
				\ 'disableSyntaxes': []
			\ },
			\ 'buffer': {
				\ 'enable': v:true,
				\ 'firstMatch': v:true,
				\ 'shortcut': 'B',
				\ 'priority': 1,
				\ 'disableSyntaxes': [],
				\ 'ignoreGitignore': v:true
			\ },
			\ 'file': {
				\ 'enable': v:true,
				\ 'shortcut': 'F',
				\ 'priority': 10,
				\ 'disableSyntaxes': [],
				\ 'triggerCharacters': '/',
				\ 'trimSameExts': ['.ts', '.js'],
				\ 'ignoreHidden': v:true,
				\ 'ignorePatterns': []
			\ },
			\ 'outline': {
				\ 'ctagsFilestypes': []
			\ }
		\ },
		\ 'github': {
			\ 'filetypes': ['gitcommit', 'markdown.ghpull'],
		\ },
	\ },
	\ 'snippets': {
		\ 'priority': 200,
		\ 'shortcut': 'S',
		\ 'ultisnips': { 
			\ 'enable': v:true
		\ },
	\ },
	\ 'highlight': {
		\ 'disableLanguages': '',
		\ 'document.enable': v:true,
		\ 'colors.enable': v:true
	\ },
	\  'python': {
		\ 'jediEnabled': 0,
		\ 'linting': { 'pylintUseMinimalCheckers': 0 },
	\ },
	\ 'emmet': {
		\ 'includeLanguages': { 'javascript': 'javascriptreact' },
	\ },
	\ 'rust': {
		\ 'clippy_preference': 'on',
	\ },
\ }

let s:languageservers = {}
for [lsp, config] in s:LSP_CONFIG
  " COC chokes on emptykcommands https://github.com/neoclide/coc.nvim/issues/418#issuecomment-462106680"
  let s:not_empty_cmd = !empty(get(config, 'command'))
  if s:not_empty_cmd | let s:languageservers[lsp] = config | endif

  " Disable tsserver when flow is loaded"
  if lsp ==# 'flow' && s:not_empty_cmd | call coc#config('tsserver', { 'enableJavascript': 0 }) | endif
endfor

if !empty(s:languageservers)
  call coc#config('languageserver', s:languageservers)
endif

" Go to definition of word under cursor "
nmap <silent> <Leader>dd <Plug>(coc-definition) 
nmap <silent> <Leader>dt <Plug>(coc-type-definition)
" Find references "
nmap <silent> <Leader>dr <Plug>(coc-references) 
" Go to implementation "
nmap <silent> <Leader>dj <Plug>(coc-implementation) 

" rename the current word in the cursor "
nmap <Leader>rn  <Plug>(coc-rename)
nmap <Leader>fs  <Plug>(coc-format-selected)

" restart when tsserver gets wonky "
nnoremap <silent> <Leader>cr  :<C-u>CocRestart<CR>

" Use K for show documentation in preview window"
nnoremap <silent> K :call <SID>ahmed#autocmds#showdocumentation#()<CR>

" manage extensions "
nnoremap <silent> <Leader>cx  :<C-u>CocList extensions<cr>

augroup cocsettings
	autocmd!
	" Update signature help on jump placeholder."
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	" Highlight symbol under cursor on CursorHold"
	autocmd CursorHold * silent call CocActionAsync('highlight')
	autocmd BufWritePost coc.vim source % | CocRestart
	autocmd BufWritePost {coc-settings,tsconfig}.json,.flowconfig CocRestart
	autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport'
augroup end