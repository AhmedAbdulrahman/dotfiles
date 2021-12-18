return function()
  require('bufferline').setup({
    options = {
      right_mouse_command = 'bdelete! %d',
      left_mouse_command = 'buffer %d',
      show_buffer_close_icons = false,
      show_close_icon = false,
      enforce_regular_tabs = true,
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      separator_style = 'slant',
      --- count is an integer representing total count of errors
      --- level is a string "error" | "warning"
      --- diagnostics_dict is a dictionary from error level
      -- ("error", "warning" or "info")to number of errors for each level.
      --- this should return a string
      --- Don't get too fancy as this function will be executed a lot
      diagnostics_indicator = function(count, level)
        local icon = level:match('error') and ' ' or ' '
        return ' ' .. icon .. count
      end,
      offsets = {
        {
          filetype = 'undotree',
          text = 'Undotree',
          highlight = 'PanelHeading',
          padding = 1,
        },
        {
          filetype = 'NvimTree',
          text = 'Explorer',
          highlight = 'PanelHeading',
          padding = 1,
        },
        {
          filetype = 'DiffviewFiles',
          text = 'Diff View',
          highlight = 'PanelHeading',
          padding = 1,
        },
        {
          filetype = 'flutterToolsOutline',
          text = 'Flutter Outline',
          highlight = 'PanelHeading',
        },
        {
          filetype = 'packer',
          text = 'Packer',
          highlight = 'PanelHeading',
          padding = 1,
        },
      },
    },
  })
end
