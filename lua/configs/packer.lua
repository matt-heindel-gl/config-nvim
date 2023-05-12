-- Package Manager

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

  -- Fuzzy Finder
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

  -- File Explorer
  use 'nvim-tree/nvim-web-devicons'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- Color Scheme
  use 'tomasiser/vim-code-dark'

  -- Syntax Highlighting, Language Parsing
	use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})

  -- Git
	use('tpope/vim-fugitive')
  -- :GBrowse to open file on remote
  use 'tpope/vim-rhubarb'

  -- LSP
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}

  -- prettier
  use('prettier/vim-prettier')

  -- auto bracket pairs
  use('echasnovski/mini.pairs')

  -- comment lines with 'gcc'
  use('echasnovski/mini.comment')

  -- highlight word orccurances
  use('echasnovski/mini.cursorword')

  -- smooth scroll
  use 'yuttie/comfortable-motion.vim'

  -- file switching
  use 'theprimeagen/harpoon'

  -- scollbar + colors
  use 'petertriho/nvim-scrollbar'
  use 'folke/tokyonight.nvim'
  use 'folke/lsp-colors.nvim'

  -- diagnostic virtual text
  use {
      "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
  }

  -- git marks in gutter
  use 'airblade/vim-gitgutter'

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

end)
