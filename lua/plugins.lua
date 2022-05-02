-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Lua Dev Facility
    use "folke/lua-dev.nvim"
    use "glepnir/dashboard-nvim"

    -- Best Theme
    use { "ellisonleao/gruvbox.nvim" }

    -- TreeSitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- LSP utils
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'kdheepak/cmp-latex-symbols' -- Latex symbols for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'onsails/lspkind-nvim' -- completion items

    use 'p00f/clangd_extensions.nvim'
    use 'simrat39/rust-tools.nvim'

    use 'ray-x/lsp_signature.nvim'

    use 'tami5/lspsaga.nvim'
    use "lukas-reineke/indent-blankline.nvim"

    -- Agda tools
    use 'ashinkarov/nvim-agda'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    use {
	'kyazdani42/nvim-tree.lua',
	requires = {
	    'kyazdani42/nvim-web-devicons', -- optional, for file icon
	}
    }

    -- Git 
    use "lewis6991/gitsigns.nvim"

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} },
    use {'nvim-telescope/telescope-ui-select.nvim' },

    use "nanozuki/tabby.nvim",
    use "feline-nvim/feline.nvim",
    use "SmiteshP/nvim-gps",
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    } 
}
end)

