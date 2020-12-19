scriptencoding utf-8

let g:startify_padding_left = 5
let g:startify_relative_path = 1
let g:startify_fortune_use_unicode = 1
let g:startify_change_to_vcs_root = 1
let g:startify_update_oldfiles = 1
let g:startify_use_env = 1
let g:startify_enable_special = 0
let g:startify_files_number = 10
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1

if has('nvim')
     let g:startify_ascii = [
          \ '           _     ',
          \ '  __ _  __(_)_ _ ',
          \ ' /  \ |/ / /  / \',
          \ '/_/_/___/_/_/_/_/',
          \ '']
else
     let g:startify_ascii = [
          \ '       _     ',
          \ ' _  __(_)_ _ ',
          \ '| |/ / /  / \',
          \ '|___/_/_/_/_/',
          \ '']
endif
let g:startify_custom_header = 'map(startify#fortune#boxed() + g:startify_ascii, "repeat(\" \", 5).v:val")'

let g:startify_custom_header_quotes = startify#fortune#predefined_quotes() + [
      \ ['Simplicity is a great virtue but it requires hard work to achieve it', 'and education to appreciate it. And to make matters worse: complexity sells better.', '', '― Edsger W. Dijkstra'],
      \ ['A common fallacy is to assume authors of incomprehensible code will be able to express themselves clearly in comments.'],
      \ ['Your time is limited, so don’t waste it living someone else’s life. Don’t be trapped by dogma — which is living with the results of other people’s thinking. Don’t let the noise of others’ opinions drown out your own inner voice. And most important, have the courage to follow your heart and intuition. They somehow already know what you truly want to become. Everything else is secondary.', '', '— Steve Jobs, June 12, 2005'],
      \ ['If a feature is sometimes dangerous, and there is a better option, then always use the better option.', '', '- Douglas Crockford'],
      \ ['The best way to make your dreams come true is to wake up.', '', '― Paul Valéry'],
      \ ['Fast is slow, but continuously, without interruptions', '', '– Japanese proverb'],
      \ ['A language that doesn’t affect the way you think about programming is not worth knowing.', '- Alan Perlis'],
      \ ['Bad programmers worry about the code. Good programmers worry about data structures and their relationships', '' , '― Linus Torvalds'],
      \ ['Work expands to fill the time available for its completion.', '', "― C. Northcote Parkinson (Parkinson's Law)"],
      \ ['Future regret minimization is a powerful force for good judgement.', '', '― Tobi Lutke'],
      \ ['The works must be conceived with fire in the soul but executed with clinical coolness', '', '― Joan Miró'],
      \ ['I call it my billion-dollar mistake. It was the invention of the null reference in 1965. At that time, I was designing the first comprehensive type system for references in an object oriented language. My goal was to ensure that all use of references should be absolutely safe, with checking performed automatically by the compiler. But I couldn’t resist the temptation to put in a null reference, simply because it was so easy to implement. This has led to innumerable errors, vulnerabilities, and system crashes, which have probably caused a billion dollars of pain and damage in the last forty years.', '', '― Tony Hoare, the inventor of Null References'],
      \ ['I think that large objected-oriented programs struggle with increasing complexity as you build this large object graph of mutable objects. You know, trying to understand and keep in your mind what will happen when you call a method and what will the side effects be.', '', '― Rich Hickey']
      \ ]

function! s:gitModified()
	let files = systemlist('git ls-files -m 2>/dev/null')
	return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore"
function! s:gitUntracked()
	let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
	return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitListCommits()
  let git = 'git -C '. getcwd()
  let commits = systemlist(git .' log --no-decorate --oneline -n 10')

  " if we are not inside a git repo don't show anything"
  if commits[0] =~? '^fatal:'
    return []
  endif

  " let git = 'G'. git[1:] fugitive doesnt support -C flag https://github.com/tpope/vim-fugitive/blob/511d3035d4da2453a9cb0188b6020ed7bc8fc18f/autoload/fugitive.vim#L2477-L2478"
  let git = 'Git'

  return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

function! s:tasks()
python3 << EOF
import subprocess
import json
import vim
tasks = json.loads(subprocess.check_output(['task', 'export']))
tasks = [{'line': task['description'],'cmd': ':TW ' + str(task['id'])} for task in tasks][:10]
vim.command("let tasklist = %s"% tasks)
EOF
    return tasklist
endfunction

let g:startify_lists = [
	\ { 'type': 'commands' },
	\ { 'header': [ '   Sessions 📆' ], 'type': 'sessions' },
	\ { 'header': [ '   Recent files in current directory 📂 [' . getcwd() . ']' ], 'type': 'dir' },
	\ { 'header': [ '   Bookmarks 🔖' ], 'type': 'bookmarks' },
	\ { 'header': [ '   Tasks 📒'], 'type': function('s:tasks') },
	\ { 'header': [ '   Modified 🔴'], 'type': function('s:gitModified') },
	\ { 'header': [ '   Untracked 🟢'], 'type': function('s:gitUntracked') },
	\ { 'header': [ '   Commits 🔀'], 'type': function('s:gitListCommits') },
	\ { 'header': [ '   Recent files 📁' ], 'type': 'files' },
	\ ]

let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ '^/tmp',
	  \ '^/cache',
      \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
      \ 'plugged/.*/doc',
      \ 'pack/.*/doc',
      \ '.*/vimwiki/.*'
      \ ]

augroup MyStartify
  autocmd!
  autocmd User Startified setlocal cursorline
augroup END
