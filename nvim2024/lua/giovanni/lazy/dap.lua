return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require('dap')

            dap.configurations.java = {
                {
                    type = 'java',
                    request = 'attach',
                    name = 'Debug (Attach) - Remote',
                    hostName = '127.0.0.1',
                    port = 5005,
                }
            }

            vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
            vim.keymap.set('n', '<leader>dl', function() require('dap').step_over() end)
            vim.keymap.set('n', '<leader>dj', function() require('dap').step_into() end)
            vim.keymap.set('n', '<leader>dk', function() require('dap').step_out() end)
            vim.keymap.set('n', '<leader>dt', function() require('dap').toggle_breakpoint() end)
            vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end)
            vim.keymap.set({'n', 'v'}, '<leader>dh', function()
              require('dap.ui.widgets').hover()
            end)
            vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
              require('dap.ui.widgets').preview()
            end)
            vim.keymap.set('n', '<Leader>df', function()
              local widgets = require('dap.ui.widgets')
              widgets.centered_float(widgets.frames)
            end)
            vim.keymap.set('n', '<Leader>ds', function()
              local widgets = require('dap.ui.widgets')
              widgets.centered_float(widgets.scopes)
            end)

        end
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            require('nvim-dap-virtual-text').setup({
                commented = true
            })
        end
    },
}
