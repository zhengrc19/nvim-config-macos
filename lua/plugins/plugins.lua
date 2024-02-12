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
  { -- file tree
    "nvim-tree/nvim-tree.lua", version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require('plugins.nvimtree') end,
  }, { -- status bar (bottom)
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require('plugins.lualine') end,
  }, { -- tab bar
    'akinsho/bufferline.nvim', version = "*",
    dependencies = { 'nvim-tree/nvim-web-devicons', 'moll/vim-bbye' },
    config = function() require('plugins.bufferline') end,
  },
  -------------------------------------------------------------------------
  ----------------------------- BETTER EDITOR -----------------------------
  -------------------------------------------------------------------------
  { -- language grammar parser
    "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
  }, { -- language-specific comments
    'numToStr/Comment.nvim', config = function() require('Comment').setup() end,
  }, { -- determine # of indent spaces
    'Darazaki/indent-o-matic', config = function() require('indent-o-matic').setup{} end,
  }, { -- indentation marker lines
    "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {},
    config = function() require("ibl").setup() end,
  }, { -- change surrounding quotes
    "kylechui/nvim-surround", version = "*", event = "VeryLazy",
    config = function() require("nvim-surround").setup{} end
  }, { -- rainbow color brackets
    'HiPhish/rainbow-delimiters.nvim',
  }, { -- pair brackets 
    'windwp/nvim-autopairs', event = "InsertEnter", opts = {}
  },
  -------------------------------------------------------------------------
  ----------------- COLOR THEME: Onedark inspired by Atom -----------------
  -------------------------------------------------------------------------
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup({
        toggle_style_key = '<leader>ls',
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
