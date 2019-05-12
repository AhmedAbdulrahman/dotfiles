" Insert shebang string according to filetype."
inoreabbrev <expr> _#! ahmed#abbreviations#shebang()

" Wipeout current buffer."
cnoreabbrev <expr> x getcmdtype() == ':' && getcmdline() ==# 'x'
	\ ? 'bwipeout'
	\ : 'exit'
