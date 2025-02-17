--[[return {
    'olimorris/codecompanion.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter'
    },
    opts = {
        strategies = {
            chat = {
                adapter = "r1_local"
            },
            inline = {
                adapter = "r1_local"
            }
        },
        adapters =  {
            r1_local = function ()
                return require("codecompanion.adapters").extend("ollama", {
                    name = 'r1_local',
                    schema = {
                        model = {
                            default = 'deepseek-r1'
                        }
                    }
                })
            end
        }
    }
}]]--
return {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function()
        vim.g.codeium_manual = true
        vim.keymap.set('i', '<C-n>', function() return vim.fn['codeium#CycleOrComplete']() end, { expr = true, silent = true })
        vim.keymap.set('n', '<leader>ai', function() return vim.fn['codeium#Chat']() end, { expr = true, silent = true })
    end
}
