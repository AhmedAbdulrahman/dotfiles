""
" Asynchronous lint engine for Neovim and Vim 8+."
""

scriptencoding UTF-8

let g:ale_enabled = v:true
let g:ale_fix_on_save = v:true
let g:ale_shell = &shell
let g:ale_shell_arguments = &shellcmdflag
let g:ale_command_wrapper = ''
let g:ale_set_signs = has('signs')
let g:ale_max_signs = -1
let g:ale_maximum_file_size = v:null
let g:ale_cache_executable_check_failures = v:false
let g:ale_warn_about_trailing_blank_lines = v:true
let g:ale_warn_about_trailing_whitespace = v:true
let g:ale_set_balloons = v:false
let g:ale_set_balloons_legacy_echo = v:null

" Completion options."
let g:ale_completion_enabled = v:false
let g:ale_completion_excluded_words = []
let g:ale_completion_max_suggestions = 10

" Always keep sign column open even there is no error remain."
let g:ale_sign_column_always = v:true

" Number of milliseconds before sending completion signal."
let g:ale_completion_delay = 100

" Number of milliseconds before start linting."
let g:ale_lint_delay = 300

" The sign for errors in the sign gutter."
let g:ale_sign_error = '✘'

" The sign for warnings in the sign gutter."
let g:ale_sign_warning = '⚠'

" The string used for error severity in the echoed message."
let g:ale_echo_msg_error_str = '[ERROR]'

" The string used for warning severity in the echoed message."
let g:ale_echo_msg_warning_str = '[WARNING]'

" The string used for INFO severity in the echoed message."
let g:ale_echo_msg_info_str = '[INFO]'

" Define the form of the echoed message."
let g:ale_echo_msg_format = '%severity% -> %linter% -> %code% %s'
let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']

" Disable highlighting underline on errors and warnings."
let g:ale_set_highlights = v:true

" Completely disable warnings using echo."
let g:ale_echo_cursor = v:false

" Show warnings using virtual text feature of neovim."
let g:ale_virtualtext_cursor = v:true

" Set virtual text warning prefix."
let g:ale_virtualtext_prefix = '  '

let g:ale_javascript_prettier_use_local_config = 1
function! s:PRETTIER_OPTIONS()
  return '--config-precedence prefer-file --single-quote --no-bracket-spacing --prose-wrap always --arrow-parens always --trailing-comma all --no-semi --end-of-line  lf --print-width ' . &textwidth
endfunction
let g:ale_javascript_prettier_options = <SID>PRETTIER_OPTIONS()
" Auto update the option when textwidth is dynamically set or changed in a ftplugin file"
au! OptionSet textwidth let g:ale_javascript_prettier_options = <SID>PRETTIER_OPTIONS()

let g:ale_linter_aliases = {
	  \ 'Dockerfile': 'dockerfile',
	  \ 'zsh': 'sh',
	  \ 'mail': 'markdown',
	  \ 'html': ['html', 'css']
	  \ }

" Define Linters for 'ALElinters' command."
let g:ale_linters = {
      \ 'javascript': 	['eslint'],
      \ 'typescript': 	['eslint', 'tslint'],
      \}

" Define fixers for 'ALEFix' command."
let g:ale_fixers = {
	\  '*':				['remove_trailing_lines', 'trim_whitespace'],
	\ 'html': 			['prettier'],
	\ 'css': 			['prettier', 'stylelint'],
	\ 'scss': 			['prettier'],
	\ 'yaml': 			['prettier'],
	\ 'javascript': 	['prettier'],
	\ 'typescript': 	['prettier'],
	\ 'json': 			['prettier'],
	\ 'graphql': 		['prettier'],
	\ 'markdown': 		['prettier'],
	\ 'python': 		['black'],
	\ 'sh': 			['shfmt'],
	\ 'bash': 			['shfmt'],
	\ 'go': 			['gofmt'],
\ }

" Don't auto auto-format files inside `node_modules`, `forks`, `repo`, `playground` directories, minified files and jquery (for legacy codebases)"
let g:ale_pattern_options_enabled = v:true
let g:ale_pattern_options = {
	\   '\.min\.(js\|css)$': {
	\       'ale_linters': [],
	\       'ale_fixers': []
	\   },
	\   'jquery.*': {
	\       'ale_linters': [],
	\       'ale_fixers': []
	\   },
	\   'node_modules/.*': {
	\       'ale_linters': [],
	\       'ale_fixers': []
	\   },
	\   'package.json': {
	\       'ale_fixers': g:ale_fixers['*']
	\   },
	\   'Projects/_Fork/.*': {
	\       'ale_fixers': g:ale_fixers['*']
	\   },
	\   'Projects/_Repo/.*': {
	\       'ale_fixers': g:ale_fixers['*']
	\   },
	\   'Projects/_Playground/.*': {
	\       'ale_fixers': g:ale_fixers['*']
	\   },
\ }

" Linter options."
let g:ale_lint_on_enter = v:true
let g:ale_lint_on_filetype_changed = v:true
let g:ale_lint_on_insert_leave = v:true
let g:ale_lint_on_save = v:true
let g:ale_lint_on_text_changed = 'normal'
let g:ale_linters_explicit = v:false
let g:ale_linters_ignore = {}
let g:ale_lsp_root = {}
let g:ale_type_map = {}

" Error preview options."
let g:ale_cursor_detail = v:false
let g:ale_close_preview_on_insert = v:true
let g:ale_keep_list_window_open = v:false
let g:ale_list_vertical = v:false
let g:ale_list_window_size = 5
let g:ale_open_list = v:false
let g:ale_set_loclist = v:false
let g:ale_set_quickfix = v:true
let g:ale_echo_delay = 10
let g:ale_use_global_executables = v:null
let g:ale_virtualenv_dir_names = ['.env', '.venv', 'env', 've-py3', 've', 'virtualenv', 'venv']

" History options."
let g:ale_history_enabled = v:false
let g:ale_history_log_output = v:false
let g:ale_max_buffer_history_size = 10

" Virtual text options."
let g:ale_virtualtext_delay = 10

" Sign column options."
let g:ale_change_sign_column_color = v:false
let g:ale_sign_info = g:ale_sign_warning
let g:ale_sign_offset = 1000000
let g:ale_sign_style_error = g:ale_sign_error
let g:ale_sign_style_warning = g:ale_sign_warning

" Define mappings."
nmap <LocalLeader>f <Plug>(ale_fix)
nmap [f <Plug>(ale_previous)
nmap ]f <Plug>(ale_next)
