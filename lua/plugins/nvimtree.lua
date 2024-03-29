local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end
vim.cmd [[highlight NvimTreeNormal guibg=#24262A]]

local key_opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "sf", "<cmd>NvimTreeToggle<CR>", key_opts)

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local keymap = vim.keymap.set

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  keymap('n', '<CR>',  api.node.open.edit,             opts('Open'))
  keymap('n', 'l',     api.node.open.edit,             opts('Open'))
  keymap('n', 'i',     api.node.open.edit,             opts('Open'))
  keymap('n', 'o',     api.node.run.system,            opts('Open in Finder'))
  keymap('n', 'n',     api.tree.change_root_to_node,   opts('CD'))
  keymap('n', '<C-r>', api.fs.rename_full,             opts('Rename: Full Path'))
  keymap('n', 'h',     api.tree.change_root_to_parent, opts('Up'))
  keymap('n', 'K',     api.node.show_info_popup,       opts('Info'))
  keymap('n', 'sf',    api.tree.close,                 opts('Close'))
end

-- OR setup with some options
nvim_tree.setup({
  on_attach = my_on_attach,
  sort = {
    sorter = "case_sensitive",
  },
  renderer = {
    group_empty = true,
    indent_markers = {
      enable = true,
    },
    icons = {
      glyphs = {
        git = {
          unstaged = 'M',
          untracked = 'U'
        }
      }
    }
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
  help = {
    sort_by = "desc",
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  }
})

-- vim.api.nvim_create_autocmd("BufEnter", {
--   nested = true,
--   callback = function()
--     if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
--       vim.cmd "quit"
--     end
--   end
-- })


-- auto-close solution taken from https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#rwblokzijl

local function tab_win_closed(winnr)
  local api = require"nvim-tree.api"
  local tabnr = vim.api.nvim_win_get_tabpage(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local buf_info = vim.fn.getbufinfo(bufnr)[1]
  local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
  local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
  if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
    -- Close all nvim tree on :q
    if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
      api.tree.close()
    end
  else                                                      -- else closed buffer was normal buffer
    if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
      local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
      if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
        vim.schedule(function ()
          if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
            vim.cmd "quit"                                        -- then close all of vim
          else                                                  -- else there are more tabs open
            vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
          end
        end)
      end
    end
  end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function ()
    local winnr = tonumber(vim.fn.expand("<amatch>"))
    vim.schedule_wrap(tab_win_closed(winnr))
  end,
  nested = true
})
