-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-S-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]

    -- set variable highlight
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_exec(
        [[
          augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]],
        false
      )
    end
  end,
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('VariableHighlight', {}),
--   callback = function(ev)
--     -- set variable highlight
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client.server_capabilities.documentHighlightProvider then
--       local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", {})
--
--       vim.opt.updatetime = 1000
--
--       vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--         buffer = bufnr,
--         group = group,
--         callback = function()
--           vim.lsp.buf.document_highlight()
--         end,
--       })
--       vim.api.nvim_create_autocmd({ "CursorMoved" }, {
--         buffer = bufnr,
--         group = group,
--         callback = function()
--           vim.lsp.buf.clear_references()
--         end,
--       })
--     end,
--   end
-- })
