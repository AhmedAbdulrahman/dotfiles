Snacks = Snacks

local top_header = table.concat({
	-- https://github.com/NvChad/NvChad/discussions/2755#discussioncomment-8960250
	'           ▄ ▄                   ',
	'       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ',
	'       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ',
	'    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ',
	'  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ',
	'  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄',
	'▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █',
	'█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █',
	'    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ',
  '',
}, '\n')

local sep = vim.fn['repeat']('▁', vim.o.textwidth)

local function wrap_text(input_table, width)
	local wrapped_lines = {}

	for _, line in ipairs(input_table) do
		if line == '' then
			-- Retain empty strings as line breaks
			table.insert(wrapped_lines, '')
		else
			local line_start = 1
			while line_start <= #line do
				-- Determine the end of the current segment
				local line_end = math.min(line_start + width - 1, #line)

				-- Adjust to break at the last space within the width limit
				if line_end < #line then
					local space_pos = line:sub(line_start, line_end):find ' [^ ]*$'
					if space_pos then
						line_end = line_start + space_pos - 1
					end
				end

				-- Extract the substring and ensure it's valid
				local segment = line:sub(line_start, line_end):gsub('^%s*', '')
				if segment ~= '' then
					table.insert(wrapped_lines, segment)
				end

				line_start = line_end + 1
			end
		end
	end

	return table.concat(wrapped_lines, '\n')
end

local random_quote = function()
	local quotes = require 'config.quotes'
	math.randomseed(os.time())

	return quotes[math.random(#quotes)]
end

local header = table.concat({
	top_header,
	'',
	sep,
}, '\n')

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function(_, opts)
      -- Show select prompts relative to cursor position
      require('snacks.picker.config.layouts').select.layout.relative = 'cursor'
      -- Move explorer to the right
      require('snacks.picker.config.layouts').sidebar.layout.position = 'right'
      return vim.tbl_deep_extend('force', opts or {}, {
        bigfile = {
          notify = true, -- show notification when big file detected
          size = 1.5 * 1024 * 1024, -- 1.5MB
        },
        dashboard    = {
          preset = {
            keys = {
              {
                key = 'e',
                desc = 'New File',
                action = ':ene',
              },
              {
                desc = 'Sync',
                action = ':Lazy sync',
                key = 's',
               },
              {
                desc = 'Update',
                action = ':Lazy update',
                key = 'u',
               },
              {
                desc = 'Clean',
                action = ':Lazy clean',
                key = 'c',
               },
              {
                desc = 'Profile',
                action = ':Lazy profile',
                key = 'p',
               },
              {
                desc = 'Git Todo',
                action = ':e .git/todo.md',
                key = 't',
              },
              { key = 'q', desc = 'Quit', action = ':qa' },
            },
            header = header,
          },
          formats = {
            key = function(item)
              return {
                { '[', hl = 'special' },
                { item.key, hl = 'key' },
                { ']', hl = 'special' },
              }
            end,
          },
          sections = {
            { section = 'header' },
            { section = 'keys', gap = 1, padding = 1 },
            -- {
            --   title = 'Orgmode',
            --   icon = ' ',
            -- },
            -- {
            --   title = 'Agenda',
            --   indent = 3,
            --   action = ':lua require("orgmode").agenda:agenda()',
            --   key = 'a',
            -- },
            -- {
            --   title = 'Capture',
            --   indent = 3,
            --   action = '<leader>oc',
            --   key = 'C',
            --   padding = 1,
            -- },
            { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 2 },
            { section = 'startup' },
          },
        },
        indent       = { enabled = false },
        input = {
          win = {
            style = {
              border = {
                { '┏', highlight or 'FloatBorder' },
                { '━', highlight or 'FloatBorder' },
                { '┓', highlight or 'FloatBorder' },
                { '┃', highlight or 'FloatBorder' },
                { '┛', highlight or 'FloatBorder' },
                { '━', highlight or 'FloatBorder' },
                { '┗', highlight or 'FloatBorder' },
                { '┃', highlight or 'FloatBorder' },
              },
              relative = 'cursor',
              width = 45,
              row = -3,
              col = 0,
              wo = {
                winhighlight = 'NormalFloat:SnacksInputNormal,FloatBorder:Comment,FloatTitle:Normal',
              },
            },
          },
        },
        notifier     = {
          enabled = true,
          top_down = false,
          margin = { bottom = 1 }
        },
        explorer     = { enabled = true },
        picker       = {
          enabled = true,
          prompt = '   ',
          ui_select = true,
          layout = {
            layout = {
              backdrop = false,
            },
          },
          actions = require('trouble.sources.snacks').actions,
          icons = {
            git = {
              staged = '✓',
              deleted = '',
              ignored = ' ',
              modified = '✗',
              renamed = '',
              unmerged = ' ',
              untracked = '★',
            },
            ui = {
              live = '󰐰 ',
              hidden = '',
              ignored = '',
              unselected = '',
              selected = '✓ ',
            },
          },
          explorer = {
            opts = {
              win = {
                list = {
                  keys = {
                    ["<c-]>"] = "explorer_cd",
                  }
                }
              }
            }
          },
          previewers = {
            git = {
              native = true, -- use native (terminal) or Neovim for previewing git diffs and commits
            },
          },
          layouts = {
            default = {
              layout = {
                box = 'horizontal',
                width = 0.8,
                min_width = 120,
                height = 0.8,
                {
                  box = 'vertical',
                  border = {
                    { '┏', highlight or 'FloatBorder' },
                    { '━', highlight or 'FloatBorder' },
                    { '┓', highlight or 'FloatBorder' },
                    { '┃', highlight or 'FloatBorder' },
                    { '┛', highlight or 'FloatBorder' },
                    { '━', highlight or 'FloatBorder' },
                    { '┗', highlight or 'FloatBorder' },
                    { '┃', highlight or 'FloatBorder' },
                  },
                  title = '{source} {live}',
                  title_pos = 'center',
                  { win = 'input', height = 1, border = 'bottom' },
                  { win = 'list', border = 'none' },
                },
                { win = 'preview', border = {
                  { '┏', highlight or 'FloatBorder' },
                  { '━', highlight or 'FloatBorder' },
                  { '┓', highlight or 'FloatBorder' },
                  { '┃', highlight or 'FloatBorder' },
                  { '┛', highlight or 'FloatBorder' },
                  { '━', highlight or 'FloatBorder' },
                  { '┗', highlight or 'FloatBorder' },
                  { '┃', highlight or 'FloatBorder' },
                }, width = 0.5 },
              },
            },
          },
          win = {
            -- input window
            input = {
              keys = {
                -- ["<Esc>"] = { "close", mode = { "n", "i" } },
                ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                ["<c-b>"] = { "list_scroll_up", mode = { "i", "n" } },
                ["<c-f>"] = { "list_scroll_down", mode = { "i", "n" } },
                ['<c-t>'] = {
                  'trouble_open',
                  mode = { 'n', 'i' },
                },
              },
            },
            list = {
              wo = {
                conceallevel = 0,
              },
            },
            preview = {
              wo = {
                foldcolumn = '0',
                number = false,
                relativenumber = false,
                statuscolumn = '',
              },
            },
          },
          sources = {
            files = {
              -- fd flags
              args = vim.fn.split(
                vim.fn.split(vim.env.FZF_DEFAULT_COMMAND, '/fd ')[2],
                ' '
              ),
            },
            buffers = {
              current = false,
              sort_lastused = true,
            },
            spelling = {
              layout = { preset = 'select' },
            },
          },
          formatters = {
            selected = {
              unselected = false,
            },
          },
        },
        quickfile    = { enabled = false },
        scroll       = { enabled = false },
        statuscolumn = {
          enabled = true,
        },
        words        = { enabled = false },
      })
    end,
    keys = {
      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Lazygit                                                 │
      -- ╰─────────────────────────────────────────────────────────╯
      { "<leader>gg",  function() Snacks.lazygit() end,                                        desc = "Lazygit" },
      { "<leader>gla", function() Snacks.lazygit.log() end,                                    desc = "Lazygit Log (cwd)" },
      { "<leader>glc", function() Snacks.lazygit.log_file() end,                               desc = "Lazygit Current File History" },
      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Zen                                                     │
      -- ╰─────────────────────────────────────────────────────────╯
      { "<leader>z",   function() Snacks.zen({ win = { width = 200 } }) end,                   desc = "Zen Mode" },
      { "<leader>Z",   function() Snacks.zen.zoom() end,                                       desc = "Zoom Mode" },
      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Picker                                                  │
      -- ╰─────────────────────────────────────────────────────────╯
      { "<C-e>",       function() Snacks.picker.explorer() end,                                desc = "explorer" },
      { "<C-p>",       function() Snacks.picker.smart() end,                                   desc = "smart files" },
      { "<S-p>",       function() Snacks.picker.grep() end,                                    desc = "grep" },
      { "<leader>pw",  function() Snacks.picker.grep_word() end,                               desc = "grep word",                   mode = { "n", "v" } },

      { "<leader>pl",  function() Snacks.picker.projects() end,                                desc = "projects list" },

      { "<leader>cd",  function() Snacks.picker.diagnostics() end,                             desc = "diagnostics" },

      { "<leader>sf",  function() Snacks.picker.files() end,                                   desc = "files" },
      { "<leader>sb",  function() Snacks.picker.buffers() end,                                 desc = "buffers" },
      { "<leader>sh",  function() Snacks.picker.recent() end,                                  desc = "recent files" },
      { "<leader>sH",  function() Snacks.picker.command_history() end,                         desc = "command history" },
      { "<leader>ss",  function() Snacks.picker.search_history() end,                          desc = "search history" },
      { "<leader>sq",  function() Snacks.picker.qflist() end,                                  desc = "quickfix list" },
      { "<leader>sc",  function() Snacks.picker.colorschemes() end,                            desc = "color schemes" },
      { "<leader>sd",  function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "dotfiles" },

      { "<leader>gf",  function() Snacks.picker.git_files() end,                               desc = "git files" },
      { "<leader>gs",  function() Snacks.picker.git_status() end,                              desc = "git status" },
      { "<leader>glA", function() Snacks.picker.git_log() end,                                 desc = "log" },
      { "<leader>glC", function() Snacks.picker.git_log_file() end,                            desc = "file commits" },
    },
  }
}
