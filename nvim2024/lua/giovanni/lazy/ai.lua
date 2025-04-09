return {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local codecompanion = require("codecompanion")
        codecompanion.setup({
            adapters = {
                qwen = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        schema = {
                            model = {
                                default = "qwen2.5:14b",
                            },
                        },
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = "qwen",
                },
                inline = {
                    adapter = "qwen"
                }
            },
            display = {
                action_palette = {
                    provider = "telescope"
                }
            }
        })
        vim.keymap.set("n", "<leader>cc", function() vim.cmd [[ CodeCompanionChat Toggle ]] end)
        vim.keymap.set("n", "<leader>cn", function() vim.cmd [[ CodeCompanionChat ]] end)
        vim.keymap.set("n", "<leader>ci", ":CodeCompanion ")
        vim.keymap.set("v", "<leader>ci", ":CodeCompanion ")
        vim.keymap.set("n", "<leader>ca", function() vim.cmd [[ CodeCompanionActions ]] end)
        vim.keymap.set("v", "<leader>ce", function() codecompanion.prompt("explain") end)
    end
}

