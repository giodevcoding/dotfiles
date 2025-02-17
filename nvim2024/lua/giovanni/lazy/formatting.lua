return {
    {
        "mhartington/formatter.nvim",
        config = function()
            require("formatter").setup {
                filetype = {
                    javascript = {
                        require("formatter.filetypes.javascript").prettierd
                    },
                    javascriptreact = {
                        require("formatter.filetypes.javascriptreact").prettierd
                    },
                    typescript = {
                        require("formatter.filetypes.typescript").prettierd
                    },
                    typescriptreact = {
                        require("formatter.filetypes.typescriptreact").prettierd
                    },
                    vue = {
                        require("formatter.filetypes.vue").prettierd
                    },
                }
            }
            vim.keymap.set("n", "<leader>pr", vim.cmd.Format)
        end
    },
    "nvim-tree/nvim-web-devicons",
    "mattn/emmet-vim",
    "tpope/vim-surround",
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    -- Defaults
                    enable_close = true,         -- Auto close tags
                    enable_rename = true,        -- Auto rename pairs of tags
                    enable_close_on_slash = true -- Auto close on trailing </
                },
            })
        end
    },
    {
        'preservim/vim-markdown',
        dependencies = { 'godlygeek/tabular' }
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
}
