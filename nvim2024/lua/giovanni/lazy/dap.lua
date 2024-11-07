return {
    "mfussenegger/nvim-dap",
    {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            require('nvim-dap-virtual-text').setup({
                commented = true
            })
        end
    },
    --[[{
        'leoluz/nvim-dap-go',
        config = function() require('dap-go').setup() end
    }]]--
}
