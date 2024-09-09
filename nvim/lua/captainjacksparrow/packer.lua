vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { "rose-pine/neovim", as = "rose-pine" }
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,}
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

	use({'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'})
	use({'hrsh7th/cmp-nvim-lsp'})
	use({'hrsh7th/cmp-buffer'})
	use({
		"L3MON4D3/LuaSnip",
		tag = "v2.*", 
		run = "make install_jsregexp"
	})
	use {
		'hrsh7th/nvim-cmp',
		config = function ()
			require'cmp'.setup {
				snippet = {
					expand = function(args)
						require'luasnip'.lsp_expand(args.body)
					end
				},

				sources = {
					{ name = 'luasnip' },
					-- more sources
				},
			}
		end
	}
	use { 'saadparwaiz1/cmp_luasnip' }
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}
end)
