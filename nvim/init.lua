-- Utils
require('utils.globals')
require('utils.functions')
-- Core Config
require('core.config')
require('core.settings')
require('core.colorscheme')
require('core.lazy')
require('core.autocmds')
-- LSP Config
require('lsp.config')
require('lsp.run')
require('lsp.functions')
require('floating_man')

local g = vim.g

-- Disable unused built-in plugins. saves a lot
g.loaded_gzip = 1
g.loaded_rrhelper = 1
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

g.markdown_fenced_languages = {
  'css',
  'erb=eruby',
  'javascript',
  'js=javascript',
  'jsx=javascriptreact',
  'ts=typescript',
  'tsx=typescriptreact',
  'json=jsonc',
  'ruby',
  'sass',
  'scss=sass',
  'xml',
  'html',
  'py=python',
  'python',
  'clojure',
  'clj=clojure',
  'cljs=clojure',
  'stylus=css',
  'less=css',
  'viml=vim',
}
