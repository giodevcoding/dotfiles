return {
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
                    enable_close = true,          -- Auto close tags
                    enable_rename = true,         -- Auto rename pairs of tags
                    enable_close_on_slash = true -- Auto close on trailing </
                },
            })
        end
    },
    {
        'preservim/vim-markdown',
        dependencies = { 'godlygeek/tabular' }
    }
}