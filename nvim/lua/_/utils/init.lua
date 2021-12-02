local M = {}

function M.get_icon(icon_name)
  local ICONS = {
    paste = '⍴',
    spell = '✎',
    branch = vim.env.PURE_GIT_BRANCH ~= '' and vim.fn.trim(
      vim.env.PURE_GIT_BRANCH
    ) or ' ',
    error = ' ',
    information = ' ',
    warning = ' ',
    hint = ' ',
    lock = '',
    success = ' ',
  }

  return ICONS[icon_name] or ''
end

function M.get_color(synID, what, mode)
  return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(synID)), what, mode)
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.urlencode(str)
  str = string.gsub(
    str,
    "([^0-9a-zA-Z !'()*._~-])", -- locale independent
    function(c)
      return string.format('%%%02X', string.byte(c))
    end
  )

  str = string.gsub(str, ' ', '%%20')
  return str
end

function M.plugin_installed(name)
  local has_packer = pcall(require, 'packer')

  if not has_packer then
    return
  end

  return has_packer and packer_plugins ~= nil and packer_plugins[name]
end

function M.plugin_loaded(name)
  return M.plugin_installed(name) and packer_plugins[name].loaded
end

function M.notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = ':: Local ::' })
end

return M
