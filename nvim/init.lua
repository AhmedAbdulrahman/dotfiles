require('impatient') -- This needs to be first
require('packer_commands')
require('globals')
require('config')
require('settings')
require('colorscheme')
require('autocmds')
require('functions')
require('lsp.config')
require('lsp.run')
require('lsp.functions')
require('floating_man')

local g = vim.g

-- Disable unused built-in plugins. saves a lot
g.loaded_gzip = 1
g.loaded_rrhelper = 1
g.did_load_filetypes = 1
g.did_install_default_menus = 1
g.loaded_tarPlugin = 1
g.loaded_zipPlugin = 1
g.loaded_netrwPlugin = 1
g.loaded_getscript = 1
g.loaded_netrwFileHandlers = 1
g.loaded_netrwSettings = 1
g.loaded_2html_plugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_getscriptPlugin = 1
g.loaded_logipat = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_matchit = 1
