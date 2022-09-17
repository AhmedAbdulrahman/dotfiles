vim.opt.background = 'dark'
vim.cmd('colorscheme ' .. NvimConfig.colorscheme)

-- nvim NIGHTLY
if vim.fn.has("nvim-0.8") then
  vim.api.nvim_set_hl(0, 'NvimConfigPrimary', { fg = "#7aa2f7" });
  vim.api.nvim_set_hl(0, 'NvimConfigSecondary', { fg = "#ecc48d" });

  vim.api.nvim_set_hl(0, 'NvimConfigPrimaryBold', { bold = true, fg = "#7aa2f7" });
  vim.api.nvim_set_hl(0, 'NvimConfigSecondaryBold', { bold = true, fg = "#ecc48d" });

  vim.api.nvim_set_hl(0, 'NvimConfigHeader', { bold = true, fg = "#7aa2f7" });
  vim.api.nvim_set_hl(0, 'NvimConfigHeaderInfo', { bold = true, fg = "#ecc48d" });
  vim.api.nvim_set_hl(0, 'NvimConfigFooter', { bold = true, fg = "#ecc48d" });

  -- Tokyonight Colorscheme Specific Config
  if NvimConfig.colorscheme == 'aylin' then
    -- Lines
    vim.api.nvim_set_hl(0, 'CursorLineNR', { link = 'NvimConfigSecondary' })

    -- Floats/Windows
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = "None", fg = "None" });
    vim.api.nvim_set_hl(0, 'FloatBorder', { bg = "None", fg = "#7aa2f7"});
    vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = "None", fg = "#7aa2f7" });
    vim.api.nvim_set_hl(0, 'BufferTabpageFill', { fg = "None" });
    vim.api.nvim_set_hl(0, 'VertSplit', { bg = "#16161e", fg = "#16161e" });
    vim.api.nvim_set_hl(0, 'BqfPreviewBorder', { link = 'FloatBorder' })

    -- Telescope
    vim.api.nvim_set_hl(0, 'TelescopeTitle', { link = 'NvimConfigSecondary' });
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = "None", fg = "None" });
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = "None", fg = "#7aa2f7" });
    vim.api.nvim_set_hl(0, 'TelescopeMatching', { link = 'Constant' });

    -- Diagnostics

    -- Misc
    vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { link = 'Comment' });
    vim.api.nvim_set_hl(0, 'StatusLine', { bg = "None" });
    vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = "None" });
    -- vim.api.nvim_set_hl(0, 'rainbowcol1', { fg = aylin_colors.blue, ctermfg = 9 });
    vim.api.nvim_set_hl(0, 'Boolean', { fg = "#F7768E" });
    vim.api.nvim_set_hl(0, 'BufferOffset', { link = 'NvimConfigSecondary' });

    -- Completion Menu Colors
    local highlights = {
      CmpItemAbbr            = { fg = '#ebefff', bg = "NONE" },
      CmpItemKindClass       = { fg = '#ff9e64' },
      CmpItemKindConstructor = { fg = '#c792ea' },
      CmpItemKindFolder      = { fg = '#0db9d7' },
      CmpItemKindFunction    = { fg = '#7fdbca' },
    --   CmpItemKindInterface   = { fg = aylin_colors.teal, bg = "NONE" },
    --   CmpItemKindKeyword     = { fg = aylin_colors.magneta2 },
    --   CmpItemKindMethod      = { fg = aylin_colors.red },
    --   CmpItemKindReference   = { fg = aylin_colors.red1 },
      CmpItemKindSnippet     = { fg = '#a9b1d6' },
      CmpItemKindVariable    = { fg = '#ecc48d', bg = "NONE" },
      CmpItemKindText        = { fg = "LightGrey" },
	  CmpItemMenu            = { fg = "#FD98B9", bg = "NONE" },
      CmpItemAbbrMatch       = { fg = "#7aa2f7", bg = "NONE" },
      CmpItemAbbrMatchFuzzy  = { fg = "#7aa2f7", bg = "NONE" },
    }

    -- vim.api.nvim_set_hl(0, "CmpBorderedWindow_FloatBorder", { fg = aylin_colors.blue0 })

    for group, hl in pairs(highlights) do
      vim.api.nvim_set_hl(0, group, hl)
    end
  end

-- ELSE
else
  -- NvimConfig Colors
  vim.highlight.create('NvimConfigPrimary', { guifg = "#7aa2f7" }, false);
  vim.highlight.create('NvimConfigSecondary', { guifg = "#ecc48d" }, false);

  vim.highlight.create('NvimConfigPrimaryBold', { gui = "bold", guifg = "#7aa2f7" }, false);
  vim.highlight.create('NvimConfigSecondaryBold', { gui = "bold", guifg = "#ecc48d" }, false);

  vim.highlight.create('NvimConfigHeader', { gui = "bold", guifg = "#7aa2f7" }, false);
  vim.highlight.create('NvimConfigHeaderInfo', { gui = "bold", guifg = "#ecc48d" }, false);
  vim.highlight.create('NvimConfigFooter', { gui = "bold", guifg = "#ecc48d" }, false);

  -- Aylin Colorscheme Specific Config
  if NvimConfig.colorscheme == 'aylin' then
    -- Lines
    vim.highlight.link('CursorLineNR', 'NvimConfigSecondary', true)
    -- vim.highlight.link('LineNr', 'Comment', true)

    -- Floats/Windows
    vim.highlight.create('NormalFloat', { guibg = "None", guifg = "None" }, false);
    vim.highlight.create('FloatBorder', { guibg = "None" }, false);
    vim.highlight.create('WhichKeyFloat', { guibg = "None" }, false);
    vim.highlight.create('BufferTabpageFill', { guifg = "None" }, false);
    vim.highlight.create('VertSplit', { guibg = "#16161e", guifg = "#16161e" }, false);
    vim.highlight.link('BqfPreviewBorder', 'FloatBorder', true)

    -- Telescope
    vim.highlight.link('TelescopeTitle', 'NvimConfigSecondary', true);
    vim.highlight.create('TelescopeNormal', { guibg = "None", guifg = "None" }, false);
    vim.highlight.create('TelescopeBorder', { guibg = "None" }, false);
    vim.highlight.link('TelescopeMatching', 'Constant', true);

    -- Diagnostics

    -- Misc
    vim.highlight.link('GitSignsCurrentLineBlame', 'Comment', true);
    vim.highlight.create('StatusLine', { guibg = "None" }, false);
    vim.highlight.create('StatusLineNC', { guibg = "None" }, false);
     vim.highlight.create('Boolean', { guifg = "#F7768E" }, false);
    vim.highlight.link('BufferOffset', 'NvimConfigSecondary', true);

    -- Completion Menu Colors
    local highlights = {
    --   CmpItemAbbr            = { fg = aylin_colors.dark3, bg = "NONE" },
    --   CmpItemKindClass       = { fg = aylin_colors.orange },
    --   CmpItemKindConstructor = { fg = aylin_colors.purple },
    --   CmpItemKindFolder      = { fg = aylin_colors.blue2 },
    --   CmpItemKindFunction    = { fg = aylin_colors.blue },
    --   CmpItemKindInterface   = { fg = aylin_colors.teal, bg = "NONE" },
    --   CmpItemKindKeyword     = { fg = aylin_colors.magneta2 },
    --   CmpItemKindMethod      = { fg = aylin_colors.red },
    --   CmpItemKindReference   = { fg = aylin_colors.red1 },
    --   CmpItemKindSnippet     = { fg = aylin_colors.dark3 },
    --   CmpItemKindVariable    = { fg = aylin_colors.cyan, bg = "NONE" },
      CmpItemKindText        = { fg = "LightGrey" },
      CmpItemMenu            = { fg = "#FD98B9", bg = "NONE" },
      CmpItemAbbrMatch       = { fg = "#7aa2f7", bg = "NONE" },
      CmpItemAbbrMatchFuzzy  = { fg = "#7aa2f7", bg = "NONE" },
    }

    -- vim.api.nvim_set_hl(0, "CmpBorderedWindow_FloatBorder", { fg = aylin_colors.blue0 })

    for group, hl in pairs(highlights) do
      vim.api.nvim_set_hl(0, group, hl)
    end
  end
end
-- END
