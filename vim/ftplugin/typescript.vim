" TypeScript Settings "

setl conceallevel=2
setl isfname+=@-@

let s:package_lock = findfile('package-lock.json', expand('%:p').';')

if filereadable(s:package_lock)
  setlocal makeprg=npm
else
  setlocal makeprg=yarn
endif

" List of file extensions which are used with `gf` like commands."
setlocal suffixesadd=.ts,.tsx

let b:undo_ftplugin = 'setl conceallevel< makeprg< isfname<'
