local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -------------------------------------------------------------------------
  ---------------------------- BASIC FEATURES -----------------------------
  -------------------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua", version = "*", lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require('plugins.nvimtree') end,
  },
  {
    'nvim-lualine/lualine.nvim', lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require('plugins.lualine') end,
  },
  {
    'akinsho/bufferline.nvim', lazy = false, version = "*",
    dependencies = { 'nvim-tree/nvim-web-devicons', 'moll/vim-bbye' },
    config = function() require('plugins.bufferline') end,
  },
  -------------------------------------------------------------------------
  ----------------------------- BETTER EDITOR -----------------------------
  -------------------------------------------------------------------------
  { -- language grammar parser
    "nvim-treesitter/nvim-treesitter", lazy = false,
    build = ":TSUpdate"
  },
  { -- language-specific comments
    'numToStr/Comment.nvim', lazy = false,
    config = function() require('Comment').setup() end,
  }, 
  { -- determine # of indent spaces
    'Darazaki/indent-o-matic', lazy = false,
    config = function() require('indent-o-matic').setup{} end,
  },
  { -- indentation marker lines
    "lukas-reineke/indent-blankline.nvim", lazy = false, main = "ibl", opts = {},
    config = function() require("ibl").setup() end,
  },
  { -- change surrounding quotes
    "kylechui/nvim-surround", version = "*", event = "VeryLazy",
    config = function() require("nvim-surround").setup{} end
  },
  { 'HiPhish/rainbow-delimiters.nvim', lazy = false }, -- rainbow color brackets
  { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} }, -- pair brackets
  -------------------------------------------------------------------------
  ----------------- COLOR THEME: Onedark inspired by Atom -----------------
  -------------------------------------------------------------------------
  {
    'navarasu/onedark.nvim', lazy = false,
    config = function()
      require('onedark').setup({
        toggle_style_key = '<leader>ts',
      })
      require('onedark').load()
    end,
  },
  -------------------------------------------------------------------------
  ------------------------------ IDE FEATURES -----------------------------
  -------------------------------------------------------------------------
  { -- built-in terminal
    'akinsho/toggleterm.nvim', version = "*",
    config = function() require('plugins.toggleterm') end
  }, { -- LSP installer and config
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
})
