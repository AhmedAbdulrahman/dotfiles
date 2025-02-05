return {
  {
    'akinsho/git-conflict.nvim',
    lazy = false,
    event = "BufRead",
    version = "*", -- Load the latest release
    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "GitConflictDetected",
        callback = function()
          vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
        end,
      })

      require('conflict').setup({
        default_mappings = true,    -- disable buffer local mapping created by this plugin
        default_commands = true,    -- disable commands created by this plugin
        disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
        list_opener = 'copen',      -- command or function to open the conflicts list
        highlights = {              -- They must have background color, otherwise the default color will be used
          incoming = "DiffText",
          current = "DiffAdd",
        },
			})

      vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "#293919" })
      vim.api.nvim_set_hl(0, "GitConflictIncomingLabel", { bold = true, bg = "#698F3F" })

    end,
    keys = {
      {
        '<leader>gcb',
        '<cmd>GitConflictChooseBoth<CR>',
        desc = 'choose both',
      },
      {
        '<leader>gcn',
        '<cmd>GitConflictNextConflict<CR>',
        desc = 'move to next conflict',
      },
      {
        '<leader>gcc',
        '<cmd>GitConflictChooseOurs<CR>',
        desc = 'choose current',
      },
      {
        '<leader>gcp',
        '<cmd>GitConflictPrevConflict<CR>',
        desc = 'move to prev conflict',
      },
      {
        '<leader>gci',
        '<cmd>GitConflictChooseTheirs<CR>',
        desc = 'choose incoming',
      },
    },
  },
  {
    'sindrets/diffview.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    enabled = true,
    event = 'BufRead',
    config = function()
      local lib = require('diffview.lib')
      local diffview = require('diffview')

      local keymap = vim.keymap
      local silent = { silent = true }

     -- Toggle file history function via <leader>gd
      toggle_file_history = function()
        local view = lib.get_current_view()
        if view == nil then
          diffview.file_history()
          return
        end

        if view then
          view:close()
          lib.dispose_view(view)
        end
      end
      -- Toggle status function via <leader>gs
      toggle_status = function()
        local view = lib.get_current_view()
        if view == nil then
          diffview.open()
          return
        end

        if view then
          view:close()
          lib.dispose_view(view)
        end
      end

      keymap.set('n', '<leader>gd', '<cmd>lua toggle_file_history()<CR>', silent)
      keymap.set('n', '<leader>gs', '<cmd>lua toggle_status()<CR>', silent)

    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local gitsigns = require('gitsigns')

      local line = vim.fn.line

      vim.keymap.set('n', 'M', '<cmd>Gitsigns debug_messages<cr>')
      vim.keymap.set('n', 'mm', '<cmd>Gitsigns dump_cache<cr>')

      gitsigns.setup({
        debug_mode = true,
        max_file_length = 100000,
        signs = {
          add = { show_count = false },
          change = { show_count = false },
          delete = { show_count = true },
          topdelete = { show_count = true },
          changedelete = { show_count = true },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              gs.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              gs.nav_hunk('prev')
            end
          end)

          map('n', '<leader>hs', gs.stage_hunk)
          map('n', '<leader>hr', gs.reset_hunk)

          map('v', '<leader>hs', function()
            gs.stage_hunk({ line('.'), line('v') })
          end)

          map('v', '<leader>hr', function()
            gs.reset_hunk({ line('.'), line('v') })
          end)

          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)

          map('n', '<leader>hb', function()
            gs.blame_line({full=true})
          end)

          map('n', '<leader>hg', function()
            gs.blame()
          end)

          map('n', '<leader>hi', gs.preview_hunk_inline)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', ':Gitsigns diffthis ~')

          map('n', '<leader>hld', function()
            gs.diffthis(vim.b.gitsigns_blame_line_dict.sha..'~1')
          end)

          map('n', '<leader>hB', ':Gitsigns change_base ~')

          -- Toggles
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>td', gs.toggle_deleted)
          map('n', '<leader>tw', gs.toggle_word_diff)

          map('n', '<leader>hQ', function() gs.setqflist('all') end)
          map('n', '<leader>hq', gs.setqflist)

          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
        preview_config = {
          border = 'rounded',
        },
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 50,
        },
        count_chars = {
          '⒈',
          '⒉',
          '⒊',
          '⒋',
          '⒌',
          '⒍',
          '⒎',
          '⒏',
          '⒐',
          '⒑',
          '⒒',
          '⒓',
          '⒔',
          '⒕',
          '⒖',
          '⒗',
          '⒘',
          '⒙',
          '⒚',
          '⒛',
        },
        sign_priority = 100,
        attach_to_untracked = true,
        update_debounce = 50,
        word_diff = true,
        trouble = true,
      })
    end,
    event = 'BufRead',
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = {
      "Octo",
    },
    config = function()
      local wk_present, wk = pcall(require, "which-key")
      local octo_present, octo = pcall(require, "octo")

      if not wk_present and not octo_present then
        return
      end

      octo.setup({
        mappings = {
          issue = {
            close_issue = { lhs = "<LocalLeader>ic", desc = "close issue" },
            reopen_issue = { lhs = "<LocalLeader>io", desc = "reopen issue" },
            list_issues = { lhs = "<LocalLeader>il", desc = "list open issues on same repo" },
            reload = { lhs = "R", desc = "reload issue" },
            open_in_browser = { lhs = "B", desc = "open issue in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            add_assignee = { lhs = "<LocalLeader>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<LocalLeader>ad", desc = "remove assignee" },
            create_label = { lhs = "<LocalLeader>lc", desc = "create label" },
            add_label = { lhs = "<LocalLeader>la", desc = "add label" },
            remove_label = { lhs = "<LocalLeader>ld", desc = "remove label" },
            -- goto_issue = { lhs = "<LocalLeader>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<LocalLeader>ca", desc = "add comment" },
            delete_comment = { lhs = "<LocalLeader>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<LocalLeader>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<LocalLeader>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<LocalLeader>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<LocalLeader>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<LocalLeader>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<LocalLeader>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<LocalLeader>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<LocalLeader>rc", desc = "add/remove 😕 reaction" },
          },
          pull_request = {
            checkout_pr = { lhs = "<LocalLeader>po", desc = "checkout PR" },
            merge_pr = { lhs = "<LocalLeader>pMm", desc = "merge commit PR" },
            squash_and_merge_pr = { lhs = "<LocalLeader>pMs", desc = "squash and merge PR" },
            list_commits = { lhs = "<LocalLeader>pc", desc = "list PR commits" },
            list_changed_files = { lhs = "<LocalLeader>pf", desc = "list PR changed files" },
            show_pr_diff = { lhs = "<LocalLeader>pd", desc = "show PR diff" },
            add_reviewer = { lhs = "<LocalLeader>va", desc = "add reviewer" },
            remove_reviewer = { lhs = "<LocalLeader>vd", desc = "remove reviewer request" },
            close_issue = { lhs = "<LocalLeader>pmc", desc = "close PR" },
            reopen_issue = { lhs = "<LocalLeader>pmo", desc = "reopen PR" },
            list_issues = { lhs = "<LocalLeader>il", desc = "list open issues on same repo" },
            reload = { lhs = "R", desc = "reload PR" },
            open_in_browser = { lhs = "B", desc = "open PR in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            goto_file = { lhs = "gf", desc = "go to file" },
            add_assignee = { lhs = "<LocalLeader>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<LocalLeader>ad", desc = "remove assignee" },
            create_label = { lhs = "<LocalLeader>lc", desc = "create label" },
            add_label = { lhs = "<LocalLeader>la", desc = "add label" },
            remove_label = { lhs = "<LocalLeader>ld", desc = "remove label" },
            -- goto_issue = { lhs = "<LocalLeader>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<LocalLeader>ca", desc = "add comment" },
            delete_comment = { lhs = "<LocalLeader>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<LocalLeader>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<LocalLeader>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<LocalLeader>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<LocalLeader>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<LocalLeader>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<LocalLeader>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<LocalLeader>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<LocalLeader>rc", desc = "add/remove 😕 reaction" },
          },
          review_thread = {
            -- goto_issue = { lhs = "<LocalLeader>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<LocalLeader>ca", desc = "add comment" },
            delete_comment = { lhs = "<LocalLeader>cd", desc = "delete comment" },
            add_suggestion = { lhs = "<LocalLeader>sa", desc = "add suggestion" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            react_hooray = { lhs = "<LocalLeader>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<LocalLeader>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<LocalLeader>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<LocalLeader>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<LocalLeader>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<LocalLeader>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<LocalLeader>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<LocalLeader>rc", desc = "add/remove 😕 reaction" },
          },
          submit_win = {
            approve_review = { lhs = "<LocalLeader>sa", desc = "approve review" },
            comment_review = { lhs = "<LocalLeader>sc", desc = "comment review" },
            request_changes = { lhs = "<LocalLeader>sr", desc = "request changes review" },
            close_review_tab = { lhs = "<LocalLeader>sx", desc = "close review tab" },
          },
          review_diff = {
            add_review_comment = { lhs = "<LocalLeader>ca", desc = "add a new review comment" },
            add_review_suggestion = { lhs = "<LocalLeader>sa", desc = "add a new review suggestion" },
            focus_files = { lhs = "<LocalLeader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<LocalLeader>b", desc = "hide/show changed files panel" },
            next_thread = { lhs = "]t", desc = "move to next thread" },
            prev_thread = { lhs = "[t", desc = "move to previous thread" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<LocalLeader><space>", desc = "toggle viewer viewed state" },
            goto_file = { lhs = "gf", desc = "go to file" },
          },
          file_panel = {
            next_entry = { lhs = "j", desc = "move to next changed file" },
            prev_entry = { lhs = "k", desc = "move to previous changed file" },
            select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
            refresh_files = { lhs = "R", desc = "refresh changed files panel" },
            focus_files = { lhs = "<LocalLeader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<LocalLeader>b", desc = "hide/show changed files panel" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<LocalLeader><Space>", desc = "toggle viewer viewed state" },
          }
        }
      })

      -- Main Octo buffer
      local function attach_octo(bufnr)
        wk.register({
          a = { name = "Assignee" },
          c = { name = "Comment" },
          g = { name = "Go To" },
          i = { name = "Issue" },
          l = { name = "Label" },
          p = {
            name = "Pull Request",
            r = { '<cmd>Octo pr ready<CR>', 'mark draft as ready to review' },
            s = { '<cmd>Octo pr checks<CR>', 'status of all checks' },
            m = { name = "Manage pull request" },
            M = { name = "Merge" },
          },
          r = { name = "Reaction" },
          s = { name = "Submit" },
          v = { name = "Reviewer" },
          R = {
            name = "Review",
            s = { '<cmd>Octo review start<CR>', 'start review' },
            r = { '<cmd>Octo review resume<CR>', 'resume' },
            m = {
              name = "Manage review",
              d = { '<cmd>Octo review discard<CR>', 'delete pending review' },
              s = { '<cmd>Octo review submit<CR>', 'submit review' },
              c = { '<cmd>Octo review comments<CR>', 'view pending comments' },
              p = { '<cmd>Octo review commit<CR>', 'pick a commit' },
            },
          }
        }, {
          buffer = bufnr,
          mode = "n",     -- NORMAL mode
          prefix = "<LocalLeader>",
          silent = true,  -- use `silent` when creating keymaps
          noremap = true, -- use `noremap` when creating keymaps
          nowait = false, -- use `nowait` when creating keymaps
        })
      end

      -- Review buffer
      local function attach_conf(bufnr)
        wk.register({
          c = { name = "Comment" },
          s = { name = "Suggestion" },

          q = { '<cmd>Octo review close<CR>', 'quit review' },
        }, {
          buffer = bufnr,
          mode = "n",     -- NORMAL mode
          prefix = "<LocalLeader>",
          silent = true,  -- use `silent` when creating keymaps
          noremap = true, -- use `noremap` when creating keymaps
          nowait = false, -- use `nowait` when creating keymaps
        })
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "octo",
        callback = function() attach_octo(0) end
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "conf",
        callback = function() attach_conf(0) end
      })
    end
  },
  {
    'ruifm/gitlinker.nvim',
    config = function()
      local gitlinker = require('gitlinker')
      local keymap = vim.keymap
      local silent = { silent = true }

      gitlinker.setup()

      keymap.set('n', '<leader>gl', function()
        gitlinker.get_buf_range_url(
          'n',
          { action_callback = gitlinker.actions.open_in_browser }
        )
      end, silent)

      keymap.set('v', '<leader>gl', function()
        gitlinker.get_buf_range_url(
          'v',
          { action_callback = gitlinker.actions.open_in_browser }
        )
      end, silent)

      keymap.set('n', 'gY', gitlinker.get_repo_url, silent)
      keymap.set('v', '<leader>gL', function()
        gitlinker.get_repo_url({
          action_callback = gitlinker.actions.open_in_browser,
        })
      end, silent)
    end,
    keys = {
      { "<Leader>gL", "<cmd>GitLink<CR>", mode = "x", desc = "get url for selection" }
    },
    cmd = "GitLink",
  },
  {
    'ThePrimeagen/git-worktree.nvim',
    config = function()
      local keymap = vim.keymap.set
      local silent = { silent = true }

      local utils = require('utils')

      require('git-worktree').setup({
        change_directory_command = "cd",  -- default: "cd",
        update_on_change = true,          -- default: true,
        update_on_change_command = "e .", -- default: "e .",
        clearjumps_on_change = true,      -- default: true,
        autopush = false,                 -- default: false,
      })

      -- ╭──────────────────────────────────────────────────────────╮
      -- │ Hooks                                                    │
      -- ╰──────────────────────────────────────────────────────────╯
      -- op = Operations.Switch, Operations.Create, Operations.Delete
      -- metadata = table of useful values (structure dependent on op)
      --      Switch
      --          path = path you switched to
      --          prev_path = previous worktree path
      --      Create
      --          path = path where worktree created
      --          branch = branch name
      --          upstream = upstream remote name
      --      Delete
      --          path = path where worktree deleted
      require('git-worktree').on_tree_change(function(op, metadata)
        if op == worktree.Operations.Switch then
          utils.log("Switched from " .. metadata.prev_path .. " to " .. metadata.path, "Git Worktree")
          Snacks.bufdelete.other()
          vim.cmd ('e')
        end
      end)

      -- ╭──────────────────────────────────────────────────────────╮
      -- │ Keymappings                                              │
      -- ╰──────────────────────────────────────────────────────────╯
      -- <Enter> - switches to that worktree
      -- <c-d> - deletes that worktree
      -- <c-f> - toggles forcing of the next deletion
      keymap("n", "<Leader>gww", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", silent)

      -- First a telescope git branch window will appear.
      -- Presing enter will choose the selected branch for the branch name.
      -- If no branch is selected, then the prompt will be used as the branch name.

      -- After the git branch window,
      -- a prompt will be presented to enter the path name to write the worktree to.

      -- As of now you can not specify the upstream in the telescope create workflow,
      -- however if it finds a branch of the same name in the origin it will use it
      keymap("n", "<Leader>gwc", "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", silent)
    end,
  }
}
