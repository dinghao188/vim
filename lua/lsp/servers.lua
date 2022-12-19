local cap = require('cmp_nvim_lsp').default_capabilities({snippetSupport = false})
local lspconfig = require('lspconfig')

lspconfig.clangd.setup { capabilities = cap }
