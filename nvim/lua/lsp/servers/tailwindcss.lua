local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

if cmp_nvim_lsp_ok then
	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.colorProvider = { dynamicRegistration = false }
end

-- Settings

local on_attach = function (client, bufnr)
    if client.server_capabilities.colorProvider then
        require('lsp/utils/documentcolors').buf_attach(bufnr)
    end
    require('illuminate').on_attach(client)
end

local filetypes = {
    'aspnetcorerazor',
    'astro',
    'astro-markdown',
    'blade',
    'django-html',
    'edge',
    'eelixir',
    'ejs',
    'erb',
    'eruby',
    'gohtml',
    'haml',
    'handlebars',
    'hbs',
    'html',
    'html-eex',
    'jade',
    'leaf',
    'liquid',
    'markdown',
    'mdx',
    'mustache',
    'njk',
    'nunjucks',
    'php',
    'razor',
    'slim',
    'twig',
    'css',
    'less',
    'postcss',
    'sass',
    'scss',
    'stylus',
    'sugarss',
    'javascript',
    'javascriptreact',
    'reason',
    'rescript',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
}

local init_options = {
    userLanguages = {
      eelixir = "html-eex",
      eruby = "erb",
      ['javascript.jsx'] = 'javascriptreact',
      ['typescript.tsx'] = 'typescriptreact',
    }
}

local settings = {
    tailwindCSS = {
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      experimental = {
        classRegex = {
          "tw`([^`]*)",
          "tw=\"([^\"]*)",
          "tw={\"([^\"}]*)",
          "tw\\.\\w+`([^`]*)",
          "tw\\(.*?\\)`([^`]*)"
        }
      },
      validate = true
    }
}

M.on_attach = on_attach;
M.filetypes = filetypes;
M.capabilities = capabilities;
M.settings = settings;
M.init_options = init_options;


  return M;
