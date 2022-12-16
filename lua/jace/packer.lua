--2 This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local packer = require('packer')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    
    use {
        'sonph/onehalf', rtp = 'vim',
    }
    use{ 
        'nvim-telescope/telescope.nvim', rtp = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'neovim/nvim-lspconfig'

    -- Auto-complete
    use{
        'hrsh7th/nvim-cmp',
        requires = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/vim-vsnip' },
            { 'hrsh7th/cmp-vsnip' },
            { 'f3fora/cmp-spell', { 'hrsh7th/cmp-calc' }, { 'hrsh7th/cmp-emoji'} },
        }
    }

    -- Show function hints
    use {
        'ray-x/lsp_signature.nvim',
    }

    -- Git signs
    use {
        'mhinz/vim-signify',
    }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    
    -- Multiple terminals
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
      require("toggleterm").setup()
    end}

    -- Brackets
    use 'jiangmiao/auto-pairs'

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'

    use {'lervag/vimtex', ft = {'tex', 'latex'}}
end)
