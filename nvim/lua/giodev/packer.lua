vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    --PACKER
    use 'wbthomason/packer.nvim'

    -- COLOR THEMES
    use 'ray-x/aurora'
    use 'bluz71/vim-moonfly-colors'
    use 'Everblush/everblush.nvim'
    use 'shaunsingh/nord.nvim'
    use {'srcery-colors/srcery-vim', as = 'srcery'}
    use 'aonemd/kuroi.vim'
    use 'haishanh/night-owl.vim'
    use 'Rigellute/rigel'
    use 'fxn/vim-monochrome' 

    --Lualine
    use {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup()
        end
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} },
    }

    -- Telescope File Browser
    use { "nvim-telescope/telescope-file-browser.nvim" }
    
    -- NERDTree
    -- use 'preservim/nerdtree'
    -- use 'ryanoasis/vim-devicons'
    -- use {'jcharum/vim-nerdtree-syntax-highlight', branch = 'escape-keys'}
    -- use 'tiagofumo/vim-nerdtree-syntax-highlight'
    
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons'
        },
        tag = 'nightly'
    }
    use 'nvim-tree/nvim-web-devicons'
    
    -- Barbar
    use {"romgrk/barbar.nvim", wants = "nvim-web-devicons"}

    -- Symbols Outline
    use ({
        'simrat39/symbols-outline.nvim',
        config = function()
            require("symbols-outline").setup()
        end
    })

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Undo Tree
    use 'mbbill/undotree'

    -- Fugitive
    use 'tpope/vim-fugitive'

    -- Autopairs
    use 'windwp/nvim-autopairs'

    -- Emmet
    use 'mattn/emmet-vim'

    -- COQ
    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        commit = '5eddd31',
        config = function()
            vim.cmd[[COQnow]]
        end
    } 
    use {
        'ms-jpq/coq.artifacts',
        branch = 'artifacts',
    } 
    use {
        'ms-jpq/coq.thirdparty',
        branch = '3p'
    } 

    -- LSP
    use 'neovim/nvim-lspconfig'
    use({
        'onsails/lspkind.nvim',
        config = function()
            require('lspkind').init()
        end,
    })

    -- LSP Saga
    use({
        'glepnir/lspsaga.nvim',
        branch = "main",
        config = function()
            local saga = require("lspsaga")
            saga.setup({})
        end,
    })

    -- Prettier
    use 'prettier/vim-prettier'

    -- ToggleTerm
    use {
        'akinsho/toggleterm.nvim',
        tag = "*",
    }

    -- markdown-preview
    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
end)
