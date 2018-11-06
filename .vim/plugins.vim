set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'easymotion/vim-easymotion'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'itchyny/vim-gitbranch'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'mattn/emmet-vim'
Plugin 'morhetz/gruvbox'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'cdata/vim-tagged-template'
Plugin 'reedes/vim-colors-pencil'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale'
Plugin 'reedes/vim-pencil'
Plugin 'epilande/vim-react-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'chrisbra/Colorizer'
Plugin 'wincent/terminus'   "Better vim + tmux"
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'metakirby5/codi.vim'

call vundle#end()

filetype plugin indent on