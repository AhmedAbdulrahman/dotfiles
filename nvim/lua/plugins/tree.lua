-- luacheck: max line length 150

return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {
      "NvimTreeOpen",
      "NvimTreeClose",
      "NvimTreeToggle",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
    },
    config = function()
      vim.api.nvim_set_keymap(
        'n',
        '<leader>f',
        "<cmd>lua require('nvim-tree.api').tree.toggle({ path = nil, current_window = false, find_file = false, update_root = false, focus = true })<CR>",
        { noremap = true, silent = true }
      )

      local api = require('nvim-tree.api')
      -- local utils = require('utils')
      -- local buf_api = require('bufferline.api')
      -- local treeview = require('nvim-tree.view')

      local gwidth = vim.api.nvim_list_uis()[1].width
      local gheight = vim.api.nvim_list_uis()[1].height
      local width = 80
      local height = 25

      local TREE_WIDTH = 30

      local git_icons = {
        unstaged = '',
        staged = '',
        unmerged = '',
        renamed = '➜',
        untracked = '',
        deleted = '',
        ignored = '◌',
      }

      local folder_icons = {
        default = '',
        open = '',
        empty = '',
        empty_open = '',
        symlink = '',
        symlink_open = '',
      }

      -- Highlight nodes according to current git status.
      -- vim.g.nvim_tree_git_hl = 1

      local function on_attach(bufnr)

      local function opts(desc)
        return {
          desc = 'nvim-tree: ' .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
      vim.keymap.set(
        'n',
        '<C-e>',
        api.node.open.replace_tree_buffer,
        opts('Open: In Place')
      )
      vim.keymap.set(
        'n',
        'O',
        api.node.open.no_window_picker,
        opts('Open: No Window Picker')
      )
      vim.keymap.set(
        'n',
        '<2-RightMouse>',
        api.tree.change_root_to_node,
        opts('CD')
      )
      vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
      vim.keymap.set(
        'n',
        '<C-v>',
        api.node.open.vertical,
        opts('Open: Vertical Split')
      )
      vim.keymap.set(
        'n',
        '<C-x>',
        api.node.open.horizontal,
        opts('Open: Horizontal Split')
      )
      vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
      vim.keymap.set(
        'n',
        '<',
        api.node.navigate.sibling.prev,
        opts('Previous Sibling')
      )
      vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
      vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
      vim.keymap.set(
        'n',
        '<BS>',
        api.node.navigate.parent_close,
        opts('Close Directory')
      )
      vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
      vim.keymap.set(
        'n',
        'K',
        api.node.navigate.sibling.first,
        opts('First Sibling')
      )
      vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
      vim.keymap.set(
        'n',
        'I',
        api.tree.toggle_gitignore_filter,
        opts('Toggle Git Ignore')
      )
      vim.keymap.set(
        'n',
        'H',
        api.tree.toggle_hidden_filter,
        opts('Toggle Dotfiles')
      )
      vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
      vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
      vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
      vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
      vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
      vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
      vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
      vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
      vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
      vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
      vim.keymap.set(
        'n',
        'Y',
        api.fs.copy.relative_path,
        opts('Copy Relative Path')
      )
      vim.keymap.set(
        'n',
        'gy',
        api.fs.copy.absolute_path,
        opts('Copy Absolute Path')
      )
      vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
      vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
      vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
      vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
      vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
      vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
      vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
      vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
    end

      -- local M = {}

      -- M.toggle = function()
      --   local view = treeview.is_visible()
      --   if not view then
      --     buf_api.set_offset(
      --       TREE_WIDTH + 1,
      --       utils.add_whitespaces(13) .. 'File Explorer'
      --     )
      --     if vim.bo.filetype == 'dashboard' then
      --       tree.open()
      --     else
      --       tree.find_file(true)
      --     end
      --     return
      --   end

      --   if view then
      --     buf_api.set_offset(0)
      --     treeview.close()
      --   end
      -- end

      -- return M
      require("nvim-tree").setup({
        on_attach = on_attach,
        --false by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree
        respect_buf_cwd = true,
        -- disables netrw completely
        disable_netrw = false,
        -- hijack netrw window on startup
        hijack_netrw = true,
        -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
        open_on_tab = false,
        -- hijack the cursor in the tree to put it at the start of the filename
        hijack_cursor = false,
        -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
        update_cwd = false,
        -- opens in place of the unnamed buffer if it's empty
        hijack_unnamed_buffer_when_opening = false,
        reload_on_bufenter = true,
        filesystem_watchers = {
          enable = true,
        },
        -- show lsp diagnostics in the signcolumn
        diagnostics = {
          enable = false,
          icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
          },
        },
        -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
        update_focused_file = {
          -- enables the feature
          enable = true,
          -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
          -- only relevant when `update_focused_file.enable` is true
          update_cwd = true,
          -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
          -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
          ignore_list = {},
        },
        -- configuration options for the system open command (`s` in the tree by default)
        system_open = {
          -- the command to run this, leaving nil should work in most cases
          cmd = '',
          -- the command arguments as a list
          args = {},
        },
        filters = {
          custom = {
            '.DS_Store',
            'fugitive:',
            '.git',
            'node_modules',
            '.cache',
            '__pycache__',
            'DS_Store',
            'bash',
            'bin',
            'tui',
            'vscode',
            'system',
            'spell',
            '4_archive',
            'android',
            'ios',
            '.dart_tool',
            '.idea',
          },
        },
        git = {
          enable = true,
          ignore = true,
          timeout = 500,
        },
        view = {
          -- width of the window, can be either a number (columns) or a string in `%`
          width = TREE_WIDTH,
          -- hide_root_folder = false,
          -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
          side = 'left',
          -- if true the tree will resize itself after opening a file
          -- auto_resize = false, unknown option
          number = false,
          relativenumber = false,
          float = {
            enable = true,
            open_win_config = {
              border = 'rounded',
              relative = 'editor',
              width = width,
              height = height,
              row = (gheight - height) * 0.4,
              col = (gwidth - width) * 0.5,
            },
          },
        },
        trash = {
          cmd = 'trash',
          require_confirm = true,
        },
        actions = {
          open_file = {
            quit_on_open = true,
            -- if true the tree will resize itself after opening a file
            resize_window = true,
            window_picker = {
              enable = true,
              chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
              exclude = {
                filetype = {
                  'notify',
                  'packer',
                  'qf',
                  'diff',
                  'fugitive',
                  'fugitiveblame',
                },
                buftype = { 'nofile', 'terminal', 'help' },
              },
            },
          },
        },
        renderer = {
          add_trailing = false,
          group_empty = true,
          highlight_git = true,
          highlight_opened_files = 'none',
          -- Only show the current folder as the root instead of full path.
          root_folder_modifier = ':t',
          indent_markers = {
            enable = false, -- Enable indent markers
            icons = {
              corner = '└ ',
              edge = '│ ',
              none = '  ',
            },
          },
          -- Disable special files.
          special_files = {
            'README.md',
            'LICENSE',
            'Makefile',
            'package.json',
            'package-lock.json',
          },
          icons = {
            -- Customize icons.
            glyphs = {
              default = '',
              symlink = '',
              git = git_icons,
              folder = folder_icons,
            },
            -- Set whether or not to show certain icons.
            show = {
              git = true,
            },
          },
        },
      })
    end
  },
}
