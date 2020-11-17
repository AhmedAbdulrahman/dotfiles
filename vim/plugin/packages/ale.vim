scriptencoding utf-8

let g:ale_completion_enabled=0
let g:ale_set_signs = has('signs')
let g:ale_max_signs = -1
let g:ale_set_balloons = v:false
let g:ale_shell = &shell
let g:ale_shell_arguments = &shellcmdflag

" Disabling highlighting"
let g:ale_set_highlights = 0

" Only on enter and save should ALE trigger"
let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = v:true
let g:ale_list_window_size = 5

let g:ale_open_list = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_insert_leave = 0

let g:ale_javascript_eslint_executable = "npx eslint"
let g:ale_javascript_prettier_executable = "npx prettier"

" Completely disable warnings using echo."
let g:ale_echo_cursor = v:false

" Number of milliseconds before start linting."
let g:ale_lint_delay = 300

" Always keep sign column open even there is no error remain."
let g:ale_sign_column_always = v:true

" Sign column options."
let g:ale_sign_error = '✖'		" The sign for errors in the sign gutter."
let g:ale_sign_warning = '⚠'	" The sign for warnings in the sign gutter."
let g:ale_sign_info = "ℹ"		" The sign for info in the sign gutter."
let g:ale_sign_offset = 1000000
let g:ale_sign_style_error = g:ale_sign_error
let g:ale_sign_style_warning = g:ale_sign_warning

" Error preview options."
let g:ale_close_preview_on_insert = v:true
let g:ale_list_window_size = 5

" Show warnings using virtual text feature of neovim."
let g:ale_virtualtext_cursor = v:true

" Set virtual text warning prefix."
let g:ale_virtualtext_prefix = '  '

" The string used for error severity in the echoed message."
let g:ale_echo_msg_error_str='[ERROR]'

" The string used for INFO severity in the echoed message."
let g:ale_echo_msg_info_str='[INFO]'

" The string used for warning severity in the echoed message."
let g:ale_echo_msg_warning_str='[WARNING]'

" Define the form of the echoed message."
let g:ale_echo_msg_format = '%severity% %linter% -> [%code%] -> %s'
let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']

" If you configure g:ale_pattern_options outside of vimrc, you need this."
let g:ale_pattern_options_enabled = 1

let g:ale_javascript_prettier_use_local_config = 1
function! s:PRETTIER_OPTIONS()
  return '--config-precedence prefer-file --single-quote --no-bracket-spacing --prose-wrap always --arrow-parens always --trailing-comma all --no-semi --end-of-line  lf --print-width ' . &textwidth
endfunction
let g:ale_javascript_prettier_options = <SID>PRETTIER_OPTIONS()

augroup ALE
  au!
  " Auto update the option when textwidth is dynamically set or changed in a ftplugin file"
  au! OptionSet textwidth let g:ale_javascript_prettier_options = <SID>PRETTIER_OPTIONS()
augroup END

let g:ale_linter_aliases = {
      \ 'mail': 'markdown',
      \ 'html': ['html', 'css']
      \}

let g:rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_rust_cargo_check_all_targets = 1
let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_rustfmt_options = "--edition 2018"

let g:ale_linters = {
	\   'cpp': ['cppcheck','clang','gcc'],
	\   'c': ['cppcheck','clang', 'gcc'],
	\   'python': ['flake8'],
	\   'rust': [ 'cargo', 'rls', 'rustc' ],
	\   'bash': ['shellcheck'],
	\   'sh': ['shellcheck'],
	\   'scss': ['stylelint'],
	\   'css': ['stylelint'],
	\ 	'javascript': ['eslint'],
	\ 	'typescript': ['tsserver'],
	\}

let g:ale_linters_ignore = {'python': ['pylint']}

" ESLint --fix is so slow to run it as part of the fixers, so I do this using a precommit hook or something else"
let g:ale_fixers = {
      \   '*':          ['remove_trailing_lines', 'trim_whitespace'],
	  \   'python':     ['autopep8', 'black', 'isort'],
      \   'markdown'  : ['prettier'],
      \   'javascript': ['prettier', 'eslint'],
      \   'typescript': ['prettier', 'eslint'],
      \   'css':        ['stylelint'],
      \   'scss':       ['stylelint'],
      \   'less':       ['prettier'],
      \   'json':       ['prettier'],
      \   'yaml':       ['prettier'],
      \   'graphql':    ['prettier'],
      \   'html':       ['prettier'],
      \   'reason':     ['refmt'],
      \   'sh':         ['shfmt'],
      \   'bash':       ['shfmt'],
      \   'rust':       ['rustfmt'],
      \   'go':         ['gofmt'],
      \}
