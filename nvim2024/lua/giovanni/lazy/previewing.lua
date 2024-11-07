return {
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end
    },
    {
        'weirongxu/plantuml-previewer.vim',
        dependencies = {
            'tyru/open-browser.vim',
            'aklt/plantuml-syntax'
        }
    }
}
