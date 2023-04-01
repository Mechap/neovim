vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use { 'gen740/SmoothCursor.nvim' }

    -- Lua Dev Facility
    use 'folke/neodev.nvim'
    --use "glepnir/dashboard-nvim"
    --use 'goolord/alpha-nvim'
    use {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
    }
    --use "folke/which-key.nvim"

    use "ggandor/leap.nvim"

    -- Best Theme
    use { "ellisonleao/gruvbox.nvim" }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/playground'
    use 'lewis6991/spellsitter.nvim'

    -- LSP utils
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'           -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'       -- LSP source for nvim-cmp
    use 'kdheepak/cmp-latex-symbols' -- Latex symbols for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip'   -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip'           -- Snippets plugin
    use 'onsails/lspkind-nvim'       -- completion items
    use "lukas-reineke/lsp-format.nvim"
    use "sar/friendly-snippets.nvim"

    use 'vim-autoformat/vim-autoformat'

    use "karb94/neoscroll.nvim"

    --UI
    use({
        "folke/noice.nvim",
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- "rcarriga/nvim-notify",
        }
    })

    use 'p00f/clangd_extensions.nvim'
    use 'simrat39/rust-tools.nvim'

    use "lukas-reineke/indent-blankline.nvim"
    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    -- Git
    use "lewis6991/gitsigns.nvim"

    -- Telescope
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { "nvim-telescope/telescope-file-browser.nvim" }

    use "nanozuki/tabby.nvim"
    use "feline-nvim/feline.nvim"
    use "SmiteshP/nvim-gps"

    --use { 'is0n/fm-nvim' }
end)
