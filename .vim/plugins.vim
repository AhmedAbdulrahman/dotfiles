"set the runtime path to include Vundle and initialize"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"let Vundle manage Vundle, required"
Plugin 'VundleVim/Vundle.vim'

" Utility "
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'easymotion/vim-easymotion'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'itchyny/vim-gitbranch'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'reedes/vim-colors-pencil'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'haya14busa/incsearch.vim'

" Programming Support (Formatter, Linter, Snippets) "
Plugin 'w0rp/ale'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }  "Prettier"
Plugin 'mattn/emmet-vim'
Plugin 'cdata/vim-tagged-template'
Plugin 'junegunn/rainbow_parentheses.vim'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-surround'
Plugin 'reedes/vim-pencil'
Plugin 'chrisbra/Colorizer'
Plugin 'wincent/terminus'                                 "Better vim + tmux"
Plugin 'metakirby5/codi.vim'                              "The interactive scratchpad Quakkejs"
Plugin 'sheerun/vim-polyglot'                             "A solid language pack for Vim."

" Language Support (Highlighting)"
Plugin 'pangloss/vim-javascript'                          "Javascript"
Plugin 'HerringtonDarkholme/yats.vim'                     "TypeScript"
Plugin 'mxw/vim-jsx'                                      "JSX (React)"
Plugin 'othree/html5.vim'                                 "HTML"
Plugin 'hail2u/vim-css3-syntax'                           "CSS"
Plugin 'jparise/vim-graphql'                              "GraphQL"
Plugin 'SirVer/ultisnips'                                 "snippets"
Plugin 'epilande/vim-react-snippets'                      "snippets"

" Theme / Interface "
Plugin 'vim-airline/vim-airline'
Plugin 'dempfi/vim-airline-neka'
Plugin 'morhetz/gruvbox'
Plugin 'ayu-theme/ayu-vim'
Plugin 'Yggdroot/indentLine'
Plugin 'ryanoasis/vim-devicons'


call vundle#end()

filetype plugin indent on