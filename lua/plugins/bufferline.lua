local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

vim.opt.termguicolors = true

bufferline.setup({
  options = {
    numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = "Bdelete %d", -- can be a string | function, see "Mouse actions"
    middle_mouse_command = "Bdelete %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    indicator = {
      icon = "",
      style = 'underline'
    },
    buffer_close_icon = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    -- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
    --   -- remove extension from markdown files for example
    --   if buf.name:match('%.md') then
    --     return vim.fn.fnamemodify(buf.name, ':t:r')
    --   end
    -- end,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and "" or ""
      return "" .. icon .. " " .. count
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    -- custom_filter = function(buf_number)
    --   local finded, _ = string.find(vim.bo[buf_number].filetype, "NvimTree")
    --   if finded ~= nil then
    --     return false
    --   end
    --   return true
    --   -- -- filter out filetypes you don't want to see
    --   -- if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
    --   --   return true
    --   -- end
    --   -- -- filter out by buffer name
    --   -- if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
    --   --   return true
    --   -- end
    --   -- -- filter out based on arbitrary rules
    --   -- -- e.g. filter out vim wiki buffer from tabline in your work repo
    --   -- if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
    --   --   return true
    --   -- end
    -- end,
    offsets = {
        {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",  -- | "left" | "right",
            separator = true
        }
    },
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    hover = {
        enabled = true,
        delay = 10,
        reveal = {'close'}
    },
    sort_by = 'insert_after_current',
  },
})
--
local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap("n", "<leader>gb", "<Cmd>BufferLinePick<CR>", opts)
--
-- -- vim.api.nvim_set_keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
-- -- vim.api.nvim_set_keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
-- -- vim.api.nvim_set_keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
-- -- vim.api.nvim_set_keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
-- -- vim.api.nvim_set_keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
-- -- vim.api.nvim_set_keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
-- -- vim.api.nvim_set_keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
-- -- vim.api.nvim_set_keymap("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
-- -- vim.api.nvim_set_keymap("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)
-- -- vim.api.nvim_set_keymap("n", "<leader>0", "<Cmd>BufferLineGoToBuffer 10<CR>", opts)
