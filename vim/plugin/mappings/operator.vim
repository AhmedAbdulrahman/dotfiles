" Comment and uncomment operator." 
nnoremap <silent> gc :set operatorfunc=ahmed#mappings#operator#comment#<Enter>g@
xnoremap <silent> gc :<C-u>call ahmed#mappings#operator#comment#(visualmode())<Enter>
