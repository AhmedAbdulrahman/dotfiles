return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {
      exclude = {
        filetypes = { "help", "dashboard", "packer", "NvimTree", "Trouble", "TelescopePrompt", "Float" },
        buftypes = { "terminal", "nofile", "telescope" },
      },
      indent = {
        char = "┊",
      },
      whitespace = {
        remove_blankline_trail = false,
      },
      scope = {
        char = "│",
        enabled = true,
        show_start = false,
      }
    },
    config = function()
      vim.opt.list = true
      -- vim.opt.listchars:append("space:⋅")
      -- vim.opt.listchars:append("eol:↴")
    end,
  },
  {
    'junegunn/vim-easy-align',
    config = function()
      vim.keymap.set({ 'x', 'n' }, 'ga', '<Plug>(EasyAlign)')
      vim.g.easy_align_delimiters = {
        [';'] = { pattern = ';', left_margin = 0 },
        ['['] = { pattern = '[', left_margin = 1, right_margin = 0 },
        [']'] = { pattern = ']', left_margin = 0, right_margin = 1 },
        [','] = { pattern = ',', left_margin = 0, right_margin = 1 },
        [')'] = { pattern = ')', left_margin = 0, right_margin = 0 },
        ['('] = { pattern = '(', left_margin = 0, right_margin = 0 },
        ['='] = { pattern = [[<\?=>\?]], left_margin = 1, right_margin = 1 },
        ['|'] = { pattern = [[|\?|]], left_margin = 1, right_margin = 1 },
        ['&'] = { pattern = [[&\?&]], left_margin = 1, right_margin = 1 },
        [':'] = { pattern = ':', left_margin = 1, right_margin = 1 },
        ['?'] = { pattern = '?', left_margin = 1, right_margin = 1 },
        ['<'] = { pattern = '<', left_margin = 1, right_margin = 0 },
        ['>'] = { pattern = '>', left_margin = 1, right_margin = 0 },
        ['\\'] = { pattern = '\\', left_margin = 1, right_margin = 0 },
        ['+'] = { pattern = '+', left_margin = 1, right_margin = 1 },
      }
    end,
  },
}
