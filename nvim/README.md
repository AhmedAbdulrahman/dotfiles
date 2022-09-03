Make sure to use Neovim version 0.7+. After install configuration:

1. Treesitter Languages are not installed by default.\
Make sure to run `:TSInstall <lang>` for any language you want to install.
2. LSP servers are `enabled` by default. You can enable more servers in `lua/lsp/setup.lua` just by adding standard `lspconfig.<server>.setup` function or by creating your own file and requiring in `init.lua`.
If server is not installed, it will be installed automatically.

You can check installed LSP servers by `:LspInstallInfo`.

## Configuration
To change NvimConfig related config use the `config.lua` file.
To change Nvim settings use the `settings.lua` file.

## Keybindings

Here you can find some of my custom key bindings I use in nvim config. Space `(SPC)` set as Leader key.

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
