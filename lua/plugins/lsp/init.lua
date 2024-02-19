local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local mason_lsp_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_lsp_status_ok then
  return
end

local lspconf_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconf_status_ok then
  return
end

local cmp_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_lsp_status_ok then
  return
end

mason.setup()
mason_lsp.setup()

local capabilities = cmp_nvim_lsp.default_capabilities()

require("plugins.lsp.options")

mason_lsp.setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function (server_name) -- default handler (optional)
    lspconfig[server_name].setup { capabilities = capabilities }
  end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	["rust_analyzer"] = function ()
		require("rust-tools").setup {}
	end,
	["lua_ls"] = function ()
		require("plugins.lsp.lua_ls").setup(capabilities)
	end,
	["pyright"] = function ()
		lspconfig["pyright"].setup {
      capabilities = capabilities,
      root_dir = function(fname)
        local util = require('lspconfig.util')
        local root_files = {
            'pyproject.toml',
            'setup.py',
            'setup.cfg',
            'requirements.txt',
            'Pipfile',
            'pyrightconfig.json',
        }
        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
    end,
    }
	end,
}

require("plugins.lsp.keymaps")
