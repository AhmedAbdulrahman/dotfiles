" jsdoc settings {{"
  let javascript_plugin_jsdoc = 1
  let g:jsdoc_lehre_path = '/usr/local/bin/lehre'
  let g:jsdoc_allow_input_prompt = 0
  let g:jsdoc_enable_es6 = 1
  let g:jsdoc_access_descriptions = 2
  let g:jsdoc_underscore_private = 1
  let g:jsdoc_custom_args_regex_only = 1

  let g:jsdoc_custom_args_hook = {
  \ '^\(callback\|cb\)$': {
  \   'type': ' {Function} ',
  \   'description': 'Callback function'
  \ },
  \ '\(err\|error\)$': {
  \   'type': '{Error}'
  \ },
  \ '^\(opt\|options\)$': {
  \   'type': '{Object}'
  \ },
  \ 'handler$': {
  \   'type': '{Function}'
  \ },
  \ '^\(n\|i\)$': {
  \   'type': ' {Number} '
  \ },
  \ '^i$': {
  \   'type': ' {Number} '
  \ },
  \ '^_\?\(is\|has\)': {
  \   'type': ' {Boolean} '
  \ },
  \ '^arr$': {
  \   'type': ' {Array} '
  \ },
  \ '^str$': {
  \   'type': ' {String} '
  \ },
  \ '^e$': {
  \   'type': ' {Event} '
  \ },
  \ 'el$': {
  \   'type': ' {Element} '
  \ },
  \ '^node$': {
  \   'type': ' {Element} '
  \ },
  \ '^o$': {
  \   'type': ' {Object} '
  \ },
  \ '^obj$': {
  \   'type': ' {Object} '
  \ },
  \ '^fn$': {
  \   'type': ' {Function} '
  \ },
  \}
" }}
