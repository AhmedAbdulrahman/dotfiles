-- Only required if you have packer in your `opt` pack
local packer_exists, packer = pcall(require, 'packer')
if not packer_exists then
  if vim.fn.input('Download Packer? (y for yes) ') ~= 'y' then
    return
  end

  local directory = string.format(
    '%s/pack/packer/start/',
    vim.fn.stdpath('config')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(
    string.format(
      'git clone %s %s',
      'https://github.com/wbthomason/packer.nvim',
      directory .. 'packer.nvim'
    )
  )

  print(out)
  print('Downloading packer.nvim...')
  vim.fn.execute('packadd packer.nvim')

  return
end

local lisps = { 'lisp', 'scheme', 'clojure', 'fennel' }
local PACKER_COMPILED_PATH = vim.fn.stdpath('cache')
  .. '/packer/packer_compiled.lua'

packer.init({
  max_jobs = 70, -- wbthomason/packer.nvim/issues/202
  compile_path = PACKER_COMPILED_PATH,
  package_root = string.format('%s/pack', vim.fn.stdpath('config')),
  display = {
    non_interactive = vim.env.PACKER_NON_INTERACTIVE or false,
    open_cmd = function()
      return require('packer.util').float({ border = 'single' })
    end,
  },
})

packer.startup({
  function(use)
    use({ 'wbthomason/packer.nvim' })
    use({
      'nathom/filetype.nvim',
      config = function()
        require('filetype').setup({
          overrides = {
            extensions = {
              res = 'rescript',
            },
            literal = {
              ['.stylelintrc'] = 'json',
              ['.envrc'] = 'bash',
              ['package.json'] = 'jsonc',
            },
            complex = {
              ['tsconfig*'] = 'jsonc',
            },
          },
        })
      end,
    })
    use({ 'windwp/nvim-autopairs' })
    use({ 'mg979/vim-visual-multi' })
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup({
          filetype_exclude = {
            'vimwiki',
            'man',
            'gitmessengerpopup',
            'diagnosticpopup',
            'lspinfo',
            'packer',
            'TelescopePrompt',
            'TelescopeResults',
            'help',
            'startify',
            'dashboard',
            'neogitstatus',
            'NvimTree',
            'Trouble',
            '',
          },
          buftype_exclude = { 'terminal', 'nofile' },
          space_char_blankline = ' ',
          show_foldtext = false,
          strict_tabs = true,
          debug = true,
          disable_with_nolist = true,
          max_indent_increase = 1,
          show_current_context = true,
          show_current_context_start = true,
          use_treesitter = true,
          context_patterns = {
            -- JavaScript and TypeScript
            'declaration',
            'expression',
            'pattern',
            'statement',
            'switch_case',
            'switch_default',
            'jsx_attribute',
            'jsx_element',
            'jsx_fragment',
            'jsx_self_closing_element',

            -- Bash and Go.
            '_expression',
            '_simple_statement',
            '_simple_type',
            '_statement',
            '_type',

            -- General.
            'class',
            'function',
            'method',
            'pair',
          },
        })
      end,
    })
    use({
      'akinsho/bufferline.nvim',
      config = require('_.config.bufferline'),
    })
    -- Terminal
    use({
      'akinsho/nvim-toggleterm.lua',
      keys = '<M-`>',
      config = function()
        require('toggleterm').setup({
          size = 20,
          hide_numbers = true,
          open_mapping = [[<M-`>]],
          shade_filetypes = {},
          shade_terminals = false,
          -- the degree by which to darken to terminal colour,
          -- default: 1 for dark backgrounds, 3 for light
          shading_factor = 0.3,
          start_in_insert = true,
          persist_size = true,
          direction = 'horizontal',
        })

        -- Hide number column for
        -- vim.cmd [[au TermOpen * setlocal nonumber norelativenumber]]

        -- Esc twice to get to normal mode
        vim.cmd([[tnoremap <esc><esc> <C-\><C-N>]])
      end,
    })
    -- Smooth Scrolling
    use({
      'karb94/neoscroll.nvim',
      keys = { '<C-u>', '<C-d>', 'gg', 'G' },
      config = function()
        require('neoscroll').setup({})
        local map = {}

        map['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '80' } }
        map['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '80' } }
        map['<C-b>'] = {
          'scroll',
          { '-vim.api.nvim_win_get_height(0)', 'true', '250' },
        }
        map['<C-f>'] = {
          'scroll',
          { 'vim.api.nvim_win_get_height(0)', 'true', '250' },
        }
        map['<C-y>'] = { 'scroll', { '-0.10', 'false', '80' } }
        map['<C-e>'] = { 'scroll', { '0.10', 'false', '80' } }
        map['zt'] = { 'zt', { '150' } }
        map['zz'] = { 'zz', { '150' } }
        map['zb'] = { 'zb', { '150' } }

        require('neoscroll.config').set_mappings(map)
      end,
    })
    use({
      'ibhagwan/fzf-lua',
      requires = {
        { 'vijaymarupudi/nvim-fzf' },
        --  { 'junegunn/fzf' },
      },
    })
    use({ 'kyazdani42/nvim-tree.lua' })
    use({ 'kyazdani42/nvim-web-devicons' })
    use({ 'duggiefresh/vim-easydir' })
    use({
      'ojroques/vim-oscyank',
      event = { 'TextYankPost *' },
      config = function()
        vim.cmd([[augroup __oscyank__]])
        vim.cmd([[autocmd!]])
        vim.cmd(
          [[
			autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif]]
        )
        vim.cmd([[augroup END]])
      end,
    })
    use({
      'junegunn/vim-peekaboo',
      event = 'BufReadPre',
      config = function()
        vim.g.peekaboo_window = 'vertical botright 60new'
      end,
    })
    use({
      'mbbill/undotree',
      cmd = 'UndotreeToggle',
      config = require('_.config.undotree'),
    })
    use({
      'mhinz/vim-startify',
      event = 'BufEnter',
      config = require('_.config.startify'),
    })
    use({ 'nelstrom/vim-visual-star-search' })
    use({
      'tpope/tpope-vim-abolish',
      cmd = { 'Abolish', 'S', 'Subvert' },
    })
    use({ 'tpope/vim-eunuch' })
    use({ 'tpope/vim-repeat' })
    use({ 'wincent/loupe' })
    use({
      'https://github.com/numToStr/Comment.nvim',
      requires = {
        'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
      },
      keys = { 'gc', 'gb' },
      config = require('_.config.comment'),
    })
    use({
      'ojroques/nvim-bufdel',
      cmd = 'BufDel',
      setup = function()
        local map = require('_.utils.map')
        map.nnoremap('<M-d>', ':BufDel<CR>')
      end,
      config = function()
        require('bufdel').setup({
          quit = false,
        })
      end,
    })
    use({ 'tpope/vim-apathy' })
    use({
      'simrat39/symbols-outline.nvim',
      cmd = 'SymbolsOutline',
    })
    use({
      'christoomey/vim-tmux-navigator',
      opt = true,
      cond = function()
        return vim.env.TMUX ~= nil
      end,
      config = function()
        if vim.fn.exists('g:loaded_tmux_navigator') == 0 then
          vim.g.tmux_navigator_disable_when_zoomed = 1
        end
      end,
    })
    use({ 'kevinhwang91/nvim-bqf' })
    -- LSP/Autocompletion {{{
    use({
      'neovim/nvim-lspconfig',
      requires = {
        {
          'tjdevries/lsp_extensions.nvim',
          config = require('_.config.lsp.lsp_extenstions'),
        },
        {
          'folke/todo-comments.nvim',
          config = function()
            require('todo-comments').setup({})
          end,
        },
        {
          'ray-x/lsp_signature.nvim',
          config = function()
            require('lsp_signature').setup({
              hint_prefix = '⏵', -- default is a panda emoji...
              zindex = 50,
            })
          end,
        },
        { 'folke/lua-dev.nvim' },
      },
    })
    use({
      'folke/lsp-colors.nvim',
      config = function()
        require('lsp-colors').setup({
          Error = '#f45c7f',
          Warning = '#ecc48d',
          Information = '#0db9d7',
          Hint = '#addb67',
        })
      end,
    })
    use({
      'ggandor/lightspeed.nvim',
      event = 'BufReadPost',
      config = require('_.config.lightspeed'),
    })
    use({
      'folke/trouble.nvim',
      event = 'BufReadPre',
      wants = 'nvim-web-devicons',
      cmd = { 'TroubleToggle', 'Trouble' },
      config = require('_.config.trouble'),
    })
    use({
      'mhartington/formatter.nvim',
      config = require('_.config.formatter'),
    })
    use({
      'L3MON4D3/LuaSnip',
      config = require('_.config.snippets'),
      requires = {
        { 'rafamadriz/friendly-snippets' },
      },
    })
    use({
      'hrsh7th/nvim-cmp',
      config = require('_.config.completion'),
      requires = {
        { 'onsails/lspkind-nvim' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'andersevenrud/cmp-tmux' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-path' },
        { 'PaterJason/cmp-conjure', ft = lisps },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-emoji' },
        { 'f3fora/cmp-spell' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-calc' },
      },
    })

    use({
      'David-Kunz/cmp-npm',
      config = function()
        require('cmp-npm').setup({
          ignore = {},
          only_semantic_versions = true,
        })
      end,

      requires = {
        'nvim-lua/plenary.nvim',
      },
    })

    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      requires = {
        {
          'nvim-treesitter/nvim-treesitter-textobjects',
          after = 'nvim-treesitter',
        },
        -- {
        --   'p00f/nvim-ts-rainbow',
        --   after = 'nvim-treesitter',
        -- },
        {
          'nvim-treesitter/playground',
          cmd = 'TSPlaygroundToggle',
          after = 'nvim-treesitter',
        },
        {
          'kristijanhusak/orgmode.nvim',
          run = ':TSUpdate org',
          config = function()
            require('orgmode').setup({
              org_agenda_files = {
                string.format('%s/org/*', vim.env.NOTES_DIR),
              },
              org_default_notes_file = string.format(
                '%s/org/refile.org',
                vim.env.NOTES_DIR
              ),
              mappings = {
                agenda = {
                  org_agenda_later = '>',
                  org_agenda_earlier = '<',
                },
                capture = {
                  org_capture_finalize = '<Leader>w',
                  org_capture_refile = 'R',
                  org_capture_kill = 'Q',
                },
                org = {
                  org_timestamp_up = '+',
                  org_timestamp_down = '-',
                },
              },
              org_hide_emphasis_markers = true,
              -- org_agenda_start_on_weekday = false,
              org_todo_keywords = {
                'TODO(t)',
                'PROGRESS(p)',
                '|',
                'DONE(d)',
                'REJECTED(r)',
              },
              org_agenda_templates = {
                T = {
                  description = 'Todo',
                  template = '* TODO %?\n  DEADLINE: %T',
                  target = string.format('%s/org/todos.org', vim.env.NOTES_DIR),
                },
                w = {
                  description = 'Work todo',
                  template = '* TODO %?\n  DEADLINE: %T',
                  target = string.format('%s/org/work.org', vim.env.NOTES_DIR),
                },
              },
              -- notifications = {
              --   reminder_time = { 0, 1, 5, 10 },
              --   repeater_reminder_time = { 0, 1, 5, 10 },
              --   deadline_warning_reminder_time = { 0 },
              --   cron_notifier = function(tasks)
              --     for _, task in ipairs(tasks) do
              --       local title = string.format(
              --         '%s (%s)',
              --         task.category,
              --         task.humanized_duration
              --       )
              --       local subtitle = string.format(
              --         '%s %s %s',
              --         string.rep('*', task.level),
              --         task.todo,
              --         task.title
              --       )
              --       local date = string.format(
              --         '%s: %s',
              --         task.type,
              --         task.time:to_string()
              --       )
              --
              --       if vim.fn.executable 'terminal-notifier' == 1 then
              --         vim.loop.spawn('terminal-notifier', {
              --           args = {
              --             '-title',
              --             title,
              --             '-subtitle',
              --             subtitle,
              --             '-message',
              --             date,
              --           },
              --         })
              --       end
              --
              --       if vim.fn.executable 'osascript' == 1 then
              --         vim.loop.spawn('osascript', {
              --           args = {
              --             '-e',
              --             string.format(
              --               "display notification '%s - %s' with title '%s'",
              --               subtitle,
              --               date,
              --               title
              --             ),
              --           },
              --         })
              --       end
              --     end
              --   end,
              -- },
            })
          end,
          requires = { { 'akinsho/org-bullets.nvim' } },
        },
      },
    })
    use({
      'vuki656/package-info.nvim',
      requires = { 'MunifTanjim/nui.nvim' },
      ft = { 'json' },
      config = function()
        require('package-info').setup({ force = true })
      end,
    })
    -- Syntax {{{
    use({
      'norcalli/nvim-colorizer.lua',
      config = function()
        -- norcalli/nvim-colorizer.lua/issues/4#issuecomment-543682160
        require('colorizer').setup({
          '*',
          '!vim',
          '!packer',
        }, {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = true, -- "Name" codes like Blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes: foreground, background
          mode = 'background', -- Set the display mode.
        })

        vim.cmd(
          [[ autocmd ColorScheme * lua package.loaded['colorizer'] = nil; require('colorizer').setup(); require('colorizer').attach_to_buffer(0)]]
        )
      end,
    })
    -- fancy statusline
    use({
      'nvim-lualine/lualine.nvim',
      config = require('_.config.lualine'),
      event = 'VimEnter',
      wants = 'nvim-web-devicons',
    })
    use({ 'sheerun/vim-polyglot' })
    use({
      'plasticboy/vim-markdown',
      config = require('_.config.markdown'),
      ft = { 'markdown' },
      requires = {
        { 'godlygeek/tabular', after = 'vim-markdown' },
        {
          'npxbr/glow.nvim',
          cmd = 'Glow',
          after = 'vim-markdown',
        },
      },
    })
    use({
      'iamcco/markdown-preview.nvim',
      ft = 'markdown',
      run = 'cd app && yarn install',
    })
    use({ 'jez/vim-github-hub' })
    use({ 'lumiliet/vim-twig', ft = { 'twig' } })
    -- use {
    --   'lukas-reineke/headlines.nvim',
    --   config = function()
    --     require('headlines').setup()
    --   end,
    -- }
    -- Clojure
    use({ 'guns/vim-sexp', ft = lisps })
    use({
      'tpope/vim-sexp-mappings-for-regular-people',
      ft = lisps,
    })
    use({
      'Olical/conjure',
      branch = 'master',
      ft = lisps,
    })
    -- }}}

    -- Git {{{
    use({
      'rhysd/conflict-marker.vim',
      cmd = {
        'ConflictMarkerBoth',
        'ConflictMarkerNone',
        'ConflictMarkerOurselves',
        'ConflictMarkerThemselves',
      },
      config = function()
        -- disable the default highlight group
        vim.g.conflict_marker_highlight_group = ''

        -- Include text after begin and end markers
        vim.g.conflict_marker_begin = '^<<<<<<< .*$'
        vim.g.conflict_marker_end = '^>>>>>>> .*$'
      end,
    })
    use({
      'sindrets/diffview.nvim',
      requires = { { 'nvim-lua/plenary.nvim' } },
      cmd = { 'DiffviewOpen' },
      config = function()
        require('diffview').setup({
          use_icons = false,
        })
      end,
    })
    use({
      'tpope/vim-fugitive',
      requires = {
        { 'tpope/vim-rhubarb' },
      },
    })
    use({
      'rhysd/git-messenger.vim',
      cmd = 'GitMessenger',
      keys = '<Plug>(git-messenger)',
      setup = function()
        local map = require('_.utils.map')
        map.nnoremap('<leader>gm', ':GitMessenger<CR>')
      end,
    })
    use({
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
      },
      config = function()
        require('gitsigns').setup()
      end,
    })
    -- }}}

    -- Themes, UI & eye candy {{{
    use({ 'AhmedAbdulrahman/aylin.vim', opt = true })
    -- use {
    -- 	'~/Projects/_Repo/aylin.vim',
    -- 	opt = true
    -- 	-- config = function()
    -- 	-- 	require("aylin").colorscheme()
    -- 	-- end,
    -- }
    use({
      'folke/tokyonight.nvim',
      -- config = function()
      -- 	require("tokyonight").colorscheme()
      -- end,
    })
    use({ 'axvr/photon.vim', opt = true })
    -- }}}
  end,
})

if
  not vim.g.packer_compiled_loaded and vim.loop.fs_stat(PACKER_COMPILED_PATH)
then
  vim.cmd(string.format('source %s', PACKER_COMPILED_PATH))
  vim.g.packer_compiled_loaded = true
end
