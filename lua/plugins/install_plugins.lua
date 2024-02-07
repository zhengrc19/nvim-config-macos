local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
{
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require('plugins.nvimtree')
  end,
},
{
  'numToStr/Comment.nvim',
  lazy = false,
  config = function()
    require('Comment').setup()
  end,
},
{
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('plugins.lualine')
  end,
},
{
  'navarasu/onedark.nvim',
  lazy = false,
  config = function()
    require('onedark').setup({
      toggle_style_key = '<leader>ts',
    })
    require('onedark').load()
  end,
}





})
