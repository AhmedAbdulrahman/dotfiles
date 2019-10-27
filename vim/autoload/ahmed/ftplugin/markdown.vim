""
" Markdown preview toggler.
"
" Description: See ahmed#statusline#markdownpreview() function for its indicator."
" Usage: nnoremap <buffer><silent> <LocalLeader>r :call ahmed#ftplugin#markdown#preview()<Enter>"
""
function! ahmed#ftplugin#markdown#preview() abort
	if !has('nvim')
		return v:false
	endif

	" Initialize global dictionary." 
	if !exists('g:markdownpreview')
		let g:markdownpreview = {
			\ 'opts': {},
			\ 'jobid': v:null
		\ }

		function! g:markdownpreview.opts.on_exit(jobid, data, event) abort
			let g:markdownpreview.jobid = v:null
			unlet b:markdownpreview
		endfunction
	endif

	" Stop the server if it's already running." 
	if g:markdownpreview.jobid
		call jobstop(g:markdownpreview.jobid)

	" Try to start the server." 
	else
		let g:markdownpreview.jobid = jobstart(
			\ printf(
				\ 'grip "%s" --browser --quiet',
				\ expand('%:p')
			\ ),
			\ g:markdownpreview.opts
		\ )
		let b:markdownpreview = v:true " For statusline indicator." 
	endif
endfunction
