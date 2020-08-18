""
" Slugify word under cursor"
""
" nnoremap <silent> <Plug>SlugifyNormal ciw<C-R>=ahmed#mappings#slugify#normal#(getreg('"'))<CR> :silent! call repeat#set("\<Plug>SlugifyNormal")<CR>"
" vnoremap <silent> <Plug>SlugifyVisual c<C-R>=ahmed#mappings#slugify#normal#(getreg('"'))<CR> :silent! call repeat#set("\<Plug>SlugifyVisual")<CR>"
" nmap <silent> <leader>s <Plug>SlugifyNormal"
" vmap <silent> <leader>s <Plug>SlugifyVisual"
""

function! ahmed#mappings#normal#slugify#(string) abort
	let l:finalString = a:string
    let l:chars = {
                \ '[[=a=]]': 'a',
                \ '[[=b=]]': 'b',
                \ '[[=c=]]': 'c',
                \ '[[=d=]]': 'd',
                \ '[[=e=]]': 'e',
                \ '[[=f=]]': 'f',
                \ '[[=g=]]': 'g',
                \ '[[=h=]]': 'h',
                \ '[[=i=]]': 'i',
                \ '[[=j=]]': 'j',
                \ '[[=k=]]': 'k',
                \ '[[=l=]]': 'l',
                \ '[[=m=]]': 'm',
                \ '[[=n=]]': 'n',
                \ '[[=o=]]': 'o',
                \ '[[=p=]]': 'p',
                \ '[[=q=]]': 'q',
                \ '[[=r=]]': 'r',
                \ '[[=s=]]': 's',
                \ '[[=t=]]': 't',
                \ '[[=u=]]': 'u',
                \ '[[=v=]]': 'v',
                \ '[[=w=]]': 'w',
                \ '[[=x=]]': 'x',
                \ '[[=y=]]': 'y',
                \ '[[=z=]]': 'z',
    \ }
    for [pattern, replacement] in items(l:chars)
        " Replace accented chars for their non-accented version"
		let l:finalString = substitute(l:finalString, pattern, replacement, 'g')
    endfor
	" Replace spaces with '_'"
    let l:finalString = substitute(l:finalString, ' ', '_', 'g')
    " Replace non alpha-numeric characters with '-'"
    let l:finalString = substitute(l:finalString, '[^a-zA-Z0-9_]', '-', 'g')
    " Squeeze all the '-' characters"
    let l:finalString = substitute(l:finalString, '--*', '-', 'g')
    return l:finalString
endfunction
