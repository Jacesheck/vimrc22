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
        'nvim-telescope/telescope.nvim',
        --                           tag = '0.1.0',
                                     branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('mbbill/undotree')

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use 'norcalli/nvim-colorizer.lua'

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
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},

            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
    use 'simrat39/rust-tools.nvim'

    -- Auto-formatter
    use 'jose-elias-alvarez/null-ls.nvim'

    -- Debugging
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }

    ---- Markdown
    ----use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
    --use "iamcco/markdown-preview.nvim"

    -- Diff
    use 'AndrewRadev/linediff.vim'

    -- LaTeX
    --use {'xuhdev/vim-latex-live-preview'}
end)
