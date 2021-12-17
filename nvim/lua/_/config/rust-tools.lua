return function()
	require("rust-tools").setup {
		tools = {
		  inlay_hints = {
			show_parameter_hints = true,
			parameter_hints_prefix = "  <- ",
			other_hints_prefix = "  => ",
		  },
		  hover_actions = {
			border = {
				-- fancy border
				{ "🭽", "FloatBorder" },
				{ "▔", "FloatBorder" },
				{ "🭾", "FloatBorder" },
				{ "▕", "FloatBorder" },
				{ "🭿", "FloatBorder" },
				{ "▁", "FloatBorder" },
				{ "🭼", "FloatBorder" },
				{ "▏", "FloatBorder" },

			}
		  },
		},
	  }
end
