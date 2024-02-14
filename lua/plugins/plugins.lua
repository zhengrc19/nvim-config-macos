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
  -------------------------------------------------------------------------
  ---------------------------- BASIC FEATURES -----------------------------
  -------------------------------------------------------------------------
  { -- file tree
    "nvim-tree/nvim-tree.lua", version = "*", priority = 99,
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
    "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function ()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python" },
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = { "" }, -- list of language that will be disabled
          additional_vim_regex_highlighting = false,
        },
      }
    end
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
  }, { -- git change sign column
    'lewis6991/gitsigns.nvim', config = function() require("gitsigns").setup() end,
  }, { -- git blame
    'f-person/git-blame.nvim',
    config = function () require("gitblame").setup{ delay = 1000 } end
  }, { -- show colors on hex
    'norcalli/nvim-colorizer.lua', config = function() require("colorizer").setup() end,
  }, { -- tpope's vim repeat
    'tpope/vim-repeat'
  }, { -- hop to any character
    'smoka7/hop.nvim', version = "*",
    config = function() require("plugins.hop") end,
  },
  -------------------------------------------------------------------------
  ----------------- COLOR THEME: Onedark inspired by Atom -----------------
  -------------------------------------------------------------------------
  {
    'navarasu/onedark.nvim', priority = 101,
    config = function()
      require('onedark').setup({
        toggle_style_key = '<leader>ls',
        toggle_style_list = { 'dark', 'light', 'darker', 'deep' },
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
    build = ":MasonUpdate",
  }, { -- Autocompletion
    'hrsh7th/nvim-cmp', priority = 100,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      "saadparwaiz1/cmp_luasnip",
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-cmdline',
    },
    config = function() require('plugins.autocomplete') end,
  }, { -- Snippet engine REQUIRED for autocompletion
    "L3MON4D3/LuaSnip", priority = 100,
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    dependencies = { "rafamadriz/friendly-snippets" },
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  }, { -- telescope - search plugin for everything
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", branch = '0.1.x',
      "nvim-tree/nvim-web-devicons",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function() require("plugins.telescope") end,
  }
  -- TODOS
  -- nvim-spectre
  -- LSP with telescope selection
  -- starting page (alpha nvim startify style)
  -- nvim-dap on mason
  -- nvim-tree close on last buffer
})
