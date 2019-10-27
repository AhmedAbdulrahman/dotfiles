""
" Adds additional file type glyphs to popular plugins."
""

scriptencoding UTF-8

" Based on https://github.com/zeorin/dotfiles/blob/master/.vimrc#L1019"
" Adding new icons(retarded way, but I am stupid):"
" 1. Create variable holding the icon:"
" let sample_icon = \"icon name\""
" 2. Add icon to g:icons_map"
" 3. Set icon color:"
" highlight icon_name guifg=color_code"
" 4. (Optional) Set custom icon to web devicons decoration"
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['file_extension'] = custom_icon"

let cog_icon = ""
let md_icon = ""
let json_icon = "ﬥ"
let html_icon = ""
let css_icon = ""
let scss_icon = ""
let js_icon = ""
let ts_icon = "ﯤ"
let test_icon = "ﭧ"
let orm_icon =""
let env_icon = "ﭩ"
let npm_icon = ""
let src_icon = ""
let git_icon = ""
let vim_icon = ""
let gulp_icon = ""
let license_icon = ""
let npm_folder_icon = ""

let g:icons_map = {
	\ 'ts_icon': ts_icon,
	\ 'md_icon': md_icon,
	\ 'json_icon': json_icon,
	\ 'html_icon': html_icon,
	\ 'css_icon': css_icon,
	\ 'scss_icon': scss_icon,
	\ 'js_icon': js_icon,
	\ 'cog_icon': cog_icon,
	\ 'test_icon': test_icon,
	\ 'orm_icon': orm_icon,
	\ 'env_icon': env_icon,
	\ 'git_icon': git_icon,
	\ 'vim_icon': vim_icon,
	\ 'gulp_icon': gulp_icon,
	\ 'license_icon': license_icon,
	\ 'npm_folder_icon': npm_folder_icon,
\}

" May be use for any filetype"
augroup devicons_colors
	autocmd!
	let icons = keys(g:icons_map)
	for icon in g:icons
		exec 'autocmd FileType nerdtree syntax match '.icon.'_color /\v'.g:icons_map[icon].'/ containedin=ALL'
	endfor
augroup END

highlight ts_icon_color guifg=cyan
highlight md_icon_color guifg=#5ca4ef
highlight yml_icon_color guifg=#e25141
highlight json_icon_color guifg=#f3c14f
highlight html_icon_color guifg=#d45735
highlight css_icon_color guifg=#5ca4ef
highlight scss_icon_color guifg=#ce6499
highlight js_icon_color guifg=#f7cb4f
highlight cog_icon_color guifg=#fdfdfd
highlight test_icon_color guifg=red
highlight orm_icon_color guifg=#fdfdfd
highlight env_icon_color guifg=#fdfdfd
highlight git_icon_color guifg=#6cc644
highlight vim_icon_color guifg=#8FAA54
highlight gulp_icon_color guifg=#DB4446
highlight license_icon_color guifg=#fdfdfd
highlight npm_folder_icon_color guifg=#ad403f

" Show hidden files"
let NERDTreeShowHidden= v:true

" Show folder icons in NERDTree"
" A little buggy, test if it is useful"
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let g:WebDevIconsConcealNerdtreeBrackets = v:false
let g:DevIconsEnableFoldersOpenClose = v:true
let g:DevIconsEnableFolderExtensionPatternMatching = v:true
let g:DevIconsDefaultFolderOpenSymbol=''
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol=''

" Use one space after a glyph instead of two."
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" Custom icons for file extensions"
" Next line is needed needed"
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = js_icon
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ts'] = ts_icon
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = json_icon

" Next line is needed needed"
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.test.ts'] = test_icon
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['license'] = license_icon

" Custom icons for specific filenames"
" Next line is needed needed"
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['ormconfig.js'] = orm_icon
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.env'] = env_icon
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.editorconfig'] = cog_icon
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.npmrc'] = npm_icon
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitignore'] = git_icon
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['src'] = src_icon
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['node_modules'] = npm_folder_icon

" Hide NERDTree folder trailing slashes"
" https://github.com/scrooloose/nerdtree/issues/807#issuecomment-366997266"
augroup nerdtreehidetirslashes
	autocmd!
	autocmd FileType nerdtree syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
	autocmd FileType nerdtree syntax clear NERDTreeFlags
augroup end