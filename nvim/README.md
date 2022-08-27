Make sure to use Neovim version 0.7+. After install configuration:

1. Treesitter Languages are not installed by default.\
Make sure to run `:TSInstall <lang>` for any language you want to install.
2. LSP servers are `enabled` by default. You can enable more servers in `lua/lsp/setup.lua` just by adding standard `lspconfig.<server>.setup` function or by creating your own file and requiring in `init.lua`.
If server is not installed, it will be installed automatically.

You can check installed LSP servers by `:LspInstallInfo`.

## Configuration
To change NvimConfig related config use the `config.lua` file.
To change Nvim settings use the `settings.lua` file.

## Plugins

These are the main plugins used with NVIM config:

-   [`aylin`](https://github.com/AhmedAbdulrahman/aylin.vim) - Aylin a modern and minimal VIM dark theme with bright colors.
-   [`autopairs`](https://github.com/windwp/nvim-autopairs) - Auto pair plugin
-   [`bufferline`](https://github.com/akinsho/bufferline.nvim) - A snazzy bufferline for Neovim
-   [`bufdel`](https://github.com/ojroques/nvim-bufdel) - A Neovim plugin to improve buffer deletion
-   [`bqf`](https://github.com/kevinhwang91/nvim-bqf) - Better quickfix window in Neovim, polish old quickfix window
-   [`cmp`](https://github.com/hrsh7th/nvim-cmp) - Auto completion support
    -   [`cmp-buffer`](https://github.com/hrsh7th/cmp-buffer) - cmp source for buffer words
    -   [`cmp-emoji`](https://github.com/hrsh7th/cmp-emoji) - cmp source for emoji
    -   [`cmp-lsp`](https://github.com/hrsh7th/cmp-nvim-lsp) - cmp source for LSP clent
    -   [`cmp-conjure`](https://github.com/PaterJason/cmp-conjure) - cmp source for conjure
    -   [`cmp-luasnip`](https://github.com/saadparwaiz1/cmp_luasnip) - cmp source for luasnip snippets
    -   [`cmp-path`](https://github.com/hrsh7th/cmp-path) - cmp source for filesystem paths
    -   [`cmp-spell`](https://github.com/f3fora/cmp-spell) - cmp source for spell
    -   [`cmp-cmdline`](https://github.com/hrsh7th/cmp-cmdline) - cmp source for cmdline
    -   [`cmp-calc`](https://github.com/hrsh7th/cmp-calc) - cmp source for calc
    -   [`cmp-tmux`](https://github.com/andersevenrud/cmp-tmux) - cmp source for tmux
-   [`fzf-lua`](https://github.com/ibhagwan/fzf-lua) - Lua implementation of fuzzy finder fzf plugin
-   [`formatter`](https://github.com/mhartington/formatter.nvim) - A format runner for neovim, written in lua
-   [`indent-blankline`](https://github.com/lukas-reineke/indent-blankline.nvim) - Display the indention levels with thin vertical lines
-   [`colorizer`](https://github.com/norcalli/nvim-colorizer.lua) - High-performance color highlighter
-   [`filetype`](https://github.com/nathom/filetype.nvim) - A faster version of filetype.vim
-   [`gitsigns`](https://github.com/lewis6991/gitsigns.nvim) - Asynchronous git diff in sign column
-   [`github-hub`](https://github.com/jez/vim-github-hub) - A Vim filetype plugin for github/hub
-   [`conflict-marker`](https://github.com/rhysd/conflict-marker.vim) - Weapon to fight against conflicts in Vim
-   [`fugitive`](https://github.com/tpope/vim-fugitive) - Git client
-   [`git-messenger`](https://github.com/rhysd/git-messenger.vim) - Vim and Neovim plugin to reveal the commit messages under the cursor
-   [`diffview`](https://github.com/sindrets/diffview.nvim) - Single tabpage interface for all modified files in git
-   [`plenary`](https://github.com/nvim-lua/plenary.nvim) - Asynchronous modules using coroutines
-   [`twig`](https://github.com/evidens/vim-twig) - Twig syntax highlighting, snipMate, etc
-   [`sexp`](https://github.com/guns/vim-sexp) - Precision Editing for S-expressions
-   [`lspconfig`](https://github.com/neovim/nvim-lspconfig) - Quickstart configurations for the neovim LSP client
-   [`lsp-colors`](https://github.com/folke/lsp-colors.nvim) - Create missing LSP diagnostics highlight groups for color schemes
-   [`trouble`](https://github.com/folke/trouble.nvim) - A pretty diagnostics, references, telescope results
-   [`typescript-language-server`](https://github.com/theia-ide/typescript-language-server) - TypeScript & JavaScript Language Server
-   [`css-language-server`](https://github.com/vscode-langservers/vscode-css-languageserver-bin) - CSS Language Server
-   [`html-language-server`](https://github.com/vscode-langservers/vscode-html-languageserver-bin) - HTML Language Server
-   [`json-language-server`](https://github.com/vscode-langservers/vscode-json-languageserver) - JSON Language Server
-   [`lua-language-server`](https://github.com/sumneko/lua-language-server) - Lua Language Server
-   [`luasnip`](https://github.com/L3MON4D3/LuaSnip) - High-performance snippet engine
    -   [`friendly-snippets`](https://github.com/rafamadriz/friendly-snippets) - Snippets collection for a set of different programming languages for faster development
-   [`lualine`](https://github.com/nvim-lualine/lualine.nvim) - A blazing fast and easy to configure neovim statusline plugin written in pure lua
-   [`playground`](https://github.com/nvim-treesitter/playground) - Treesitter playground integrated into Neovim
-   [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) - Nvim Treesitter configurations and abstraction layer
-   [`orgmode`](https://github.com/kristijanhusak/orgmode.nvim) - Orgmode clone written in Lua for Neovim 0.5+
-   [`nvim-tree`](https://github.com/kyazdani42/nvim-tree.lua) - File explorer
-   [`nvim-web-devicons`](https://github.com/kyazdani42/nvim-web-devicons) - Nerd Font icon API support
-   [`nvim-fzf`](https://github.com/vijaymarupudi/nvim-fzf) - Asynchronous Lua API for using fzf
-   [`vim-easydir`](https://github.com/duggiefresh/vim-easydir) - create, edit and save files and parent directories
-   [`startify`](https://github.com/mhinz/vim-startify) - 🔗 The fancy start screen for Vim.
-   [`markdown`](https://github.com/plasticboy/vim-markdown) - Markdown Vim Mode
-   [`markdown-preview`](https://github.com/iamcco/markdown-preview.nvim) - Markdown preview plugin for (neo)vim
-   [`polyglot`](https://github.com/sheerun/vim-polyglot) - Big collection of language packs as scripts are loaded only on demand
-   [`undotree`](https://github.com/mbbill/undotree) - The undo history visualizer for VIM
-   [`eunuch`](https://github.com/tpope/vim-eunuch) - Helpers for UNIX
-   [`sexp`](https://github.com/tpope/vim-sexp-mappings-for-regular-people) - Vim-sexp mappings for regular people
-   [`conjure`](https://github.com/Olical/conjure) - Interactive evaluation for Neovim (Clojure, Fennel, Janet, Racket, Hy, MIT Scheme, Guile)
-   [`loupe`](https://github.com/wincent/loupe) - Enhanced in-file search for Vim
-   [`repeat`](https://github.com/tpope/vim-repeat) - Enable repeating supported plugin maps with "."
-   [`apathy`](https://github.com/tpope/vim-apathy) - Set the 'path' option for miscellaneous file types
-   [`symbols-outline`](https://github.com/simrat39/symbols-outline.nvim) - A tree like view for symbols in Neovim
-   [`tmux-navigator`](https://github.com/christoomey/vim-tmux-navigator) - Seamless navigation between tmux panes and vim splits
-   [`abolish`](https://github.com/tpope/tpope-vim-abolish) - Easily search for, substitute, and abbreviate multiple variants of a word
-   [`visual-star-search`](https://github.com/nelstrom/vim-visual-star-search) - Start a \* or # search from a visual block
-   [`lightspeed`](https://github.com/ggandor/lightspeed.nvim) - Next-generation motion plugin with incremental input processing
-   [`package-info`](https://github.com/vuki656/package-info.nvim) - The set of npm/yarn commands
-   [`peekaboo`](https://github.com/junegunn/vim-peekaboo) - Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers

## NVIM Keybindings

These are the most useful custom key bindings I use in custom config. Space `(SPC)` set as Leader key.

<details>
<summary>Searching</summary>

### Searching

| Key Bindings | Description                     |
| ------------ | ------------------------------- |
| `SPC Tab`    | Telescope git files             |
| `SPC /`      | Telescope live grep             |
| `s`          | Enables lightspeed forward      |
| `S`          | Enables lightspeed backward     |
| `SPC s d`    | Search dotfiles                 |
| `SPC s h`    | Search file history             |
| `SPC s s`    | Search history                  |
| `<C - x>`    | Open selected file as a split   |
| `<C - v>`    | Open selected file as a vsplit  |
| `<C-t>`      | Open selected file in a new tab |

</details>

<details>
<summary>Working with LSP</summary>

### Working with LSP:

| Key Bindings               | Description                                       |
| -------------------------- | ------------------------------------------------- |
| `<C - Space>` or `SPC c a` | Code action                                       |
| `<S - K>`                  | Show documentation under cursor                   |
| `gd`                       | Go to definition                                  |
| `gr`                       | Go to references                                  |
| `]g`                       | Go to next diagnostic                             |
| `[g`                       | Go to prev diagnostic                             |
| `SPC c f`                  | Format document (usually ESLint/Prettier)         |
| `SPC c r`                  | Rename                                            |
| `SPC c q`                  | Quick fix - when I exactly know if it will fix it |
| `SPC c d`                  | Local diagnostics list                            |
| `SPC c o`                  | Organize imports                                  |

</details>

<details>
<summary>Working with Git</summary>

### Working with Git:

| Key Bindings | Description                                                                                                                              |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `SPC g g`    | Lazygit - for commiting and branch change                                                                                                |
| `SPC g s`    | Telescope status - when I want to change/search file I am working on with git changes                                                    |
| `]c`         | Go to next change hunk                                                                                                                   |
| `[c`         | Go to prev change hunk                                                                                                                   |
| `SPC g d`    | Advanced powerful diff view with many filters for debugging code, checking previous changes etc.                                         |
| `SPC g m`    | View hunk diff of a line under cursor                                                                                                    |
| `SPC g h r`  | Reset changed hunk under cursor - I like to check quickly what I have changed in that line and then just type 'u' to go back             |
| `SPC g h s`  | Stage hunk under cursor - Sometimes it's faster than selecting lines in Lazygit, so I can stage specific lines and then just do a commit |
| `SPC g l c`  | Quick check of previous commit in current buffer, <C-s> inside to switch preview                                                         |

</details>

<details>
<summary>Working with Project</summary>

### Working with Project:

| Key Bindings | Description                                                                                                                                                                                                                                                                             |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `SPC f`      | Toggles nvim-tree file explorer                                                                                                                                                                                                                                                         |
| `SPC p w`    | Find word under cursor in project - very useful to find where component is used. Just use binding and type '<'. There is a lot of alternatives like lsp_references but I like it with telescope and to not find only references but whole text under cursor.                            |
| `SPC p f`    | Find file under cursor in project - it finds files in project which contains text under cursor. Useful when you name directories by component name in React and wants to go quickly to file. 'gd' is better but in some projects without TS or with mixed JS/TS it cannot work properly |
| `SPC p t`    | Finds TODOs/NOTES in project                                                                                                                                                                                                                                                            |
| `SPC p l`    | Switch between projects                                                                                                                                                                                                                                                                 |
| `SPC p s`    | Save session to load it later from Dashboard                                                                                                                                                                                                                                            |

</details>

<details>
<summary>Commenting</summary>

### Commenting

| Key Bindings  | Description                |
| ------------- | -------------------------- |
| `gcc`         | Create/remove comment      |
| `gc` (visual) | Create/remove comment      |
| `gcO`         | Create comment line before |
| `gco`         | Create comment line after  |

</details>

<details>
<summary>Table Mode / Alignment</summary>

### Table Mode / Alignment

| Key Bindings  | Description                                                                       |
| ------------- | --------------------------------------------------------------------------------- |
| `ga (visual)` | Aligns selection based on separator (comma, semi-colon, colon etc.)               |
| `SPC t m `    | Enables Table Mode. Do it in markdown file with some table and you will see magic |
| `SPC t i C `  | (Only when Table Mode Enabled) Insert column before                               |
| `SPC t i c `  | (Only when Table Mode Enabled) Insert column after                                |
| `SPC t d c `  | (Only when Table Mode Enabled) Delete column                                      |
| `SPC t d r `  | (Only when Table Mode Enabled) Delete row                                         |
| `SPC t s `    | (Only when Table Mode Enabled) Sort table alphabetically                          |

</details>

<details>
<summary>Other VERY useful bindings</summary>

### Other VERY useful bindings

| Key Bindings | Description                                                                                                                                          |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<S-q> `     | Smartly closes current buffer without breaking UI                                                                                                    |
| `<C-a> `     | It is not only increases number, but switches between true/false/const/let/function/arrow function/increment dates etc.                              |
| `<C-n> `     | Finds next occurence (like \*) of word and puts multi-cursor there. Then you can go to Insert mode, Append, Change or Delete.                        |
| `<C-o> `     | Jumps to previous cursor in jumplist. I use it very often.                                                                                           |
| `<C-i> `     | Jumps to next cursor in jumplist.                                                                                                                    |
| `<C-u> `     | Uppercase word under cursor.                                                                                                                         |
| `v <ENTER> ` | Smartly selects next subjects of current treesitter context                                                                                          |
| `za `        | Toggle folds. By treesitter they are automatically added to TS/JS files in smart way                                                                 |
| `zM `        | Close all folds                                                                                                                                      |
| `zR `        | Open all folds                                                                                                                                       |
| `gJ `        | Smartly joins lines based on treesitter                                                                                                              |
| `gS `        | Smartly splits lines based on treesitter. I do if VERY often when I want to put import element to new lines (e.g. import { A, B, C, D, E } from ...) |
| `<F1 > `     | Opens/closes split terminal                                                                                                                          |

</details>
