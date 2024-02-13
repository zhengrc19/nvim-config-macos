local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

mason.setup()
mason_lsp.setup()

-- After setting up mason-lspconfig you may set up servers via lspconfig
lspconfig.pyright.setup {}
require("plugins.lsp.lua_ls")
-- require("lspconfig").rust_analyzer.setup {}
-- ...

require("plugins.lsp.lsp_keymaps")
