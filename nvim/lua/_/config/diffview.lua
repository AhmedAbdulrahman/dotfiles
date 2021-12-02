
-- return function()
-- 	local utils = require '_.utils'
-- 	local map = require '_.utils.map'

-- 	map('n', '<Space>gvo', '<Cmd>DiffviewOpen<CR>', { silent = true })
-- 	map('n', '<Space>gvh', '<Cmd>DiffviewFileHistory<CR>', { silent = true })

-- 	-- TODO: Add generic tab mappings and replace this with :tabclose.
-- 	map('n', '<Space>gvq', '<Cmd>DiffviewClose<CR>', { silent = true })

-- 	require('diffview').setup {
-- 		file_panel = {
-- 			position = 'bottom',
-- 			height = 10,
-- 			listing_style = 'tree',
-- 			tree_options = {
-- 			  flatten_dirs = false,
-- 			  folder_statuses = 'only_folded',
-- 			},
-- 		},
-- 	}
--   end
