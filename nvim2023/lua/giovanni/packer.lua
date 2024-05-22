vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    use {
        "nvim-telescope/telescope-dap.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    use {
        "EdenEast/nightfox.nvim",
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        { run = ":TSUpdate" }
    }

    use "theprimeagen/harpoon"

    use 'mbbill/undotree'

    use 'tpope/vim-fugitive'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                config = function()
                    require("mason").setup({
                        log_level = vim.log.levels.DEBUG
                    })
                end,
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use {
        "L3MON4D3/LuaSnip",
        run = "make install_jsregexp"
    }

    use 'mfussenegger/nvim-jdtls'

    use 'mfussenegger/nvim-dap'
    use {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            require('nvim-dap-virtual-text').setup({
                commented = true
            })
        end
    }
    use 'mxsdev/nvim-dap-vscode-js'
    --[[ use {
        'microsoft/vscode-js-debug',
        opt = true,
        run = 'npm ci --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out'
    }
    ]]
    --
    use {
        'leoluz/nvim-dap-go',
        config = function() require('dap-go').setup() end
    }
    use 'simrat39/rust-tools.nvim'

    use 'nvim-tree/nvim-web-devicons'

    use {
        'folke/trouble.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = {}
    }

    use {
        "folke/todo-comments.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup()
        end
    }


    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function() require('lualine').setup() end
    }

    use "jose-elias-alvarez/null-ls.nvim"
    use "MunifTanjim/prettier.nvim"

    use 'mattn/emmet-vim'

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use("eandrju/cellular-automaton.nvim")

    -- Zettlekasten & Telekasten
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use {
        'nvim-telescope/telescope-bibtex.nvim',
        require = { 'nvim-telescope/telescope.nvim' }
    }

    --[[use {
        'preservim/vim-markdown',
        require = { 'godlygeek/tabular' }
    }
    ]]--

    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end
    }

    use {
        'renerocksai/telekasten.nvim',
        requires = { 'nvim-telescope/telescope.nvim' }
    }

    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
        config = function() require("flutter-tools").setup {} end
    }
end)
