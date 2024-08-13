local get_nvm_node_dir = function (path)
  local entries = {}
  local handle = vim.loop.fs_scandir(path)

  if type(handle) == 'userdata' then
    local function iterator()
      return vim.loop.fs_scandir_next(handle)
    end

    for name in iterator do
      local absolute_path = path .. '/' .. name
      local relative_path = vim.fn.fnamemodify(absolute_path, ':.')
      local version_match = relative_path:match('v16.*')
      if version_match ~= nil then
        table.insert(entries, absolute_path)
      end
    end
    table.sort(entries)
  end
  return entries[#entries]
end

local node_fallback = function ()
  local node = vim.fn.exepath("node")

  if not node then
    print('Node not found in path')
    return
  end
  return node
end

local resolve_node_cmd = function ()
  local nvm_dir = vim.fn.expand('$NVM_DIR')

  if nvm_dir == "$NVM_DIR" then
    return node_fallback()
  end

  nvm_dir = nvm_dir .. "/versions/node"
  local node = get_nvm_node_dir(nvm_dir)
  if not node then
    return node_fallback()
  end
  node = node .. "/bin/node"
  return node
end


return {
  {
    'zbirenbaum/copilot.lua',
    cond = NvimConfig.plugins.ai.copilot.enabled,
    cmd = "Copilot",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup({
        ft_disable = { "go", "dap-repl" },
        copilot_node_command = node_fallback(),
        suggestion = {
          keymap = {
            accept_word = "<C-Right>",
            accept_line = "<C-Down>",
          },
        }
        -- copilot_node_command = resolve_node_cmd(),
      })
    end,
  },
  {
    'jcdickinson/codeium.nvim',
    cond = NvimConfig.plugins.ai.codeium.enabled,
    event = 'InsertEnter',
    cmd = 'Codeium',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = true,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    opts = {
      show_help = "no",
      prompts = {
        Explain = "Explain how it works.",
        Review = "Review the following code and provide concise suggestions.",
        Tests = "Briefly explain how the selected code works, then generate unit tests.",
        Refactor = "Refactor the code to improve clarity and readability.",
      },
    },
    build = function()
      vim.defer_fn(function()
        vim.cmd("UpdateRemotePlugins")
        vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
      end, 3000)
    end,
    keys = {
      { "<leader>ccb", ":CopilotChatBuffer<cr>",      desc = "CopilotChat - Buffer" },
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>",   desc = "CopilotChat - Generate tests" },
      {
        "<leader>ccT",
        "<cmd>CopilotChatVsplitToggle<cr>",
        desc = "CopilotChat - Toggle Vsplit", -- Toggle vertical split
      },
      {
        "<leader>ccv",
        ":CopilotChatVisual",
        mode = "x",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>ccc",
        ":CopilotChatInPlace<cr>",
        mode = { "n", "x" },
        desc = "CopilotChat - Run in-place code",
      },
      {
        "<leader>ccf",
        "<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
        desc = "CopilotChat - Fix diagnostic",
      },
    }
  },
  {
    'jackMort/ChatGPT.nvim',
    cond = NvimConfig.plugins.ai.chatgpt.enabled,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>t', '<cmd>ChatGPT<cr>', desc = 'ChatGPT' },
      {
        '<leader><C-t>',
        '<cmd>ChatGPTActAs<cr>',
        desc = 'ChatGPT with awesome prompt',
      },
      {
        '<leader>T',
        '<cmd>ChatGPTEditWithInstructions<cr>',
        mode = { 'x', 'n' },
        desc = 'ChatGPT with code',
      },
    },
    opts = {
      keymaps = {
        scroll_up = '<C-b>',
        scroll_down = '<C-f>',
      },
    },
    config = function()
      require('chatgpt').setup({
        keymaps = {
          close = { '<C-c>', '<Esc>' },
        },
      })
    end,
    cmd = { 'ChatGPT', 'ChatGPTEditWithInstructions' },
  },
}
