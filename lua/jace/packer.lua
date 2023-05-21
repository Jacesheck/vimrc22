vim.cmd("packadd packer.nvim")

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- Your plugins go here

    -- Colorscheme
    use "EdenEast/nightfox.nvim"

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('mbbill/undotree')
    use 'Djancyp/better-comments.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use 'nvim-treesitter/nvim-treesitter-context'

    -- Git
    use('tpope/vim-fugitive')
    use {
      'lewis6991/gitsigns.nvim',
      -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }

    -- Language server
    use {
        'VonHeikemen/lsp-zero.nvim',
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
    use 'simrat39/rust-tools.nvim'

    -- Auto-formatter
    use 'jose-elias-alvarez/null-ls.nvim'


    -- Auto-pairs
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use "windwp/nvim-ts-autotag"

    -- Toggleterm
    use {"akinsho/toggleterm.nvim", tag = '*'}

    -- Debugging
    --use 'puremourning/vimspector'

    -- Markdown
    --use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
    use "iamcco/markdown-preview.nvim"

    -- Leap
    use 'ggandor/leap.nvim'

    use 'metakirby5/codi.vim'

    use 'AndrewRadev/linediff.vim'
    --use {'stevearc/vim-arduino'}
end)
