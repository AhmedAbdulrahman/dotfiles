""
" Context-aware completion engine."
""

scriptencoding UTF-8

if !exists('g:did_coc_loaded')
  finish
endif

let g:coc_extension_root = $VIMHOME . '/coc/extensions'
let g:coc_node_path=exepath('node')


let g:coc_user_config = {
      \  'coc.preferences.colorSupport': 0,
      \  'coc.preferences.snippets.enable': v:true,
      \  'coc.preferences.colorSupport': 1,
      \  'coc.preferences.previewAutoClose': 1,
      \  'coc.preferences.snippetStatusText': 'SNIP',
      \  'coc.preferences.rootPatterns': ['.vim', '.git'],
      \  'coc.preferences.useQuickfixForLocations': 0,
      \  'coc.preferences.extensionUpdateCheck': 'daily',
      \  'coc.preferences.watchmanPath': v:null,
      \  'coc.preferences.jumpCommand': 'edit',
      \  'coc.preferences.messageLevel': 'more',
      \  'coc.preferences.bracketEnterImprove': 1,
      \  'coc.preferences.hoverTarget': functions#has_floating_window() ? 'float' : 'echo',
      \  'suggest.autoTrigger': 'always',
      \  'suggest.noselect': 0,
      \  'suggest.echodocSupport': 1,
      \  'suggest.snippetIndicator': ' [snippet]',
      \  'sugget.maxCompleteItemCount': 20,
      \  'sugget.preferCompleteThanJumpPlaceholder': 0,
      \  'sugget.fixInsertedWord': 1,
      \  'sugget.localityBonus': 1,
      \  'sugget.triggerAfterInsertEnter': 0,
      \  'sugget.timeout': 2000,
      \  'sugget.minTriggerInputLength': 1,
      \  'sugget.triggerCompletionWait': 60,
      \  'suggest.floatEnable': functions#has_floating_window(),
      \  'signature.target': functions#has_floating_window() ? 'float' : 'echo',
      \  'diagnostic.errorSign': '×',
      \  'diagnostic.warningSign': '●',
      \  'diagnostic.infoSign': '!',
      \  'diagnostic.hintSign': '!',
      \  'diagnostic.messageTarget': functions#has_floating_window() ? 'float' : 'echo',
      \  'diagnostic.refreshOnInsertMode': 1,
      \  'diagnostic.locationlist': 1,
      \  'python.linting': {
      \    'pylintUseMinimalCheckers': 0
      \   },
      \  'coc.github.filetypes': ['gitcommit', 'markdown.ghpull'],
      \  'snippets.priority': 200,
      \  'snippets.shortcut': 'S',
      \  'snippets.loadFromExtensions': 0,
      \  'snippets.ultisnips': {
      \     'enable': 1,
      \     'directories': ['snippet']
      \  },
      \ }

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word."
nmap <leader>rn <Plug>(coc-rename)

" Use K for show documentation in preview window"
nnoremap <silent> K :call <SID>show_documentation()<CR>

augroup MY_COC
  autocmd!
  " Update signature help on jump placeholder"
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd BufWritePost coc.vim source % | CocRestart
  autocmd BufWritePost coc-settings.json CocRestart
augroup end