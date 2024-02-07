local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

vim.cmd [[highlight NvimTreeNormal guibg=#24262A]]

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "sf", "<cmd>NvimTreeToggle<CR>", opts)

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
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false,
  },
  on_attach = my_on_attach,
})
