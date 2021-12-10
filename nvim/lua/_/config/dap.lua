return function()
	local map = require '_.utils.map'

	local dap = require 'dap'
	local fn = vim.fn

	fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
	fn.sign_define('DapStopped', { text = '🟢', texthl = '', linehl = '', numhl = '' })

	-- DAP Configuration for Lua
	dap.configurations.lua = {
		{
			type = 'nlua',
			request = 'attach',
			name = 'Attach to running Neovim instance',
			host = function()
			local value = fn.input 'Host [default: 127.0.0.1]: '
				return value ~= '' and value or '127.0.0.1'
			end,
			port = function()
				local val = tonumber(fn.input 'Port: ')
				assert(val, 'Please provide a port number')
				return val
			end,
		},
	}

	dap.adapters.nlua = function(callback, config)
		callback { type = 'server', host = config.host, port = config.port }
	end

	-- DAP Configuration for Rust
	dap.configurations.rust = {
		{
		  name = "Launch file",
		  type = "codelldb",
		  request = "launch",
		  program = function()
			return fn.input('Path to executable: ', fn.getcwd() .. '/', 'file')
		  end,
		  cwd = '${workspaceFolder}',
		  stopOnEntry = true,
		},
	}

	-- DAP Configuration for Python
	dap.configurations.python = {
		{
			type = 'python';
			request = 'launch';
			name = "Launch file";
			program = "${file}";
			pythonPath = function()
				return '/usr/bin/python'
			end;
		},
	}

	-- DAP Python adapter (using debugpy)
	dap.adapters.python = {
		type = 'executable';
		command = "python";
		args = { "-m", "debugpy.adapter" };
	}

	  -- NOTE: the window options can be set directly in this function
	  map.nnoremap('<localleader>dt', "<Cmd>lua require'dap'.repl.toggle()<CR>")
	  map.nnoremap('<localleader>dc', "<Cmd>lua require'dap'.continue()<CR>")
	  map.nnoremap('<localleader>de', "<Cmd>lua require'dap'.step_out()<CR>")
	  map.nnoremap('<localleader>di', "<Cmd>lua require'dap'.step_into()<CR>")
	  map.nnoremap('<localleader>do', "<Cmd>lua require'dap'.step_over()<CR>")
	  map.nnoremap('<localleader>dl', "<Cmd>lua require'dap'.run_lmapt()<CR>")
	  map.nnoremap('<localleader>db', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
	  map.nnoremap(
		'<localleader>dB',
		"<Cmd>lua require'dap'.set_breakpoint(vim.fn.input 'Breakpoint condition: ')<CR>"
	  )

end
