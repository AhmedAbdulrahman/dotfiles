""
" Context-aware completion engine."
""

scriptencoding UTF-8

" Disable automatically opening quickfix list upon errors."
let g:coc_auto_copen = v:false

let g:coc_node_path=exepath('node')

let g:coc_snippet_next='<c-j>'
let g:coc_snippet_prev='<c-k>'

" List of extensions."
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-emoji',
  \ 'coc-github',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-phpls',
  \ 'coc-python',
  \ 'coc-rls',
  \ 'coc-snippets',
  \ 'coc-svg',
  \ 'coc-tailwindcss',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-yaml',
  \ 'coc-highlight'
\ ]

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
		\ 'echodocSupport': v:true,
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
	\ 'languageserver': {},
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
  \ 'emmet': {
		\ 'includeLanguages': { 'javascript': 'javascriptreact' },
	\ },
	\ 'golang': {
		\ 'command': exepath('gopls'),
		\ 'rootPatterns': ['go.mod', '.vim/', '.git/', '.hg/'],
		\ 'filetypes': ['go'],
		\ 'initializationOptions': {
		\ 	'usePlaceholders': 1,
		\  },
	\ },
\ }

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

	autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport'
augroup end