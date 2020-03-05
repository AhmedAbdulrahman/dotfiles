let g:vim_markdown_fenced_languages = [
      \'css',
      \'erb=eruby',
      \'javascript',
      \'js=javascript',
      \'jsx=javascript.jsx',
      \'ts=typescript',
      \'tsx=typescript.tsx',
      \'json',
      \'json5',
      \'ruby',
      \'sass',
      \'scss=sass',
      \'xml',
      \'html',
      \'py=python',
      \'python',
      \'clojure',
      \'clj=clojure',
      \'clojurescript',
      \'cljs=clojurescript',
      \'stylus=css',
      \'less=css'
      \]

let g:goyo_width = '120'
let g:limelight_conceal_ctermfg=240
let g:limelight_conceal_guifg = '#777777'
nmap <Leader>g :packadd goyo<CR>\|:Goyo<CR>

" https://github.com/junegunn/goyo.vim/wiki/Customization "
function! s:goyo_enter() abort
  packadd limelight
  packadd goyo
  Limelight
  if exists('$TMUX')
    silent !tmux set -g status off
    silent !tmux set -g pane-border-status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  let b:quitting = 0
  let b:quitting_bang = 0
  augroup MyGoyoEnter
    autocmd!
    autocmd QuitPre <buffer> let b:quitting = 1
  augroup END
  cabbrev <buffer> q! let b:quitting_bang = 1 \| q!
endfunction

function! s:goyo_leave() abort
  Limelight!
  if exists('$TMUX')
    silent !tmux set -g status on
    silent !tmux set -g pane-border-status top
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  " Quit Vim if this is the only remaining buffer "
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
      qa!
    else
      silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
      qa
    endif
  endif
endfunction

" Goyo Presentation mode"
" copied from https://gist.github.com/davidmh/f4337f9ea9eca6789b3f8222b8333a35"
" use <left> and <right> to navigate the slides "

function! s:enter_presentation() abort
    " Increase conceal level "
    set conceallevel=3
    " Open first fold "
    normal ggzo
    " Add navigation "
    " C-n next slide "
        " zc - close current fold "
        " zj - move to the next "
        " zo - and open it "
        " [z - move to the start of the current fold "
        " j  - move the cursor out of the way "
    nnoremap <buffer> <right> zczjzo[z<esc>j
    " C-p previous slide "
        " zc - close current fold "
        " zk - move to the previous "
        " zo - and open it "
        " [z - move to the start of the current fold "
        " j  - move the cursor out of the way "
    nnoremap <buffer> <left> zczkzo[zj
endfunction

function! s:exit_presentation() abort
    " Reset conceal level "
    set conceallevel=0
    nunmap <buffer> <left>
    nunmap <buffer> <right>
endfunction

augroup MyMarkdownGoyo
  autocmd!
  autocmd User GoyoEnter call <SID>goyo_enter()
  autocmd User GoyoLeave call <SID>goyo_leave()
  "autocmd User GoyoEnter call <SID>enter_presentation()"
  "autocmd User GoyoLeave call <SID>exit_presentation"
augroup END
