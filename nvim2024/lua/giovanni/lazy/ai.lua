return {
    {
        "zbirenbaum/copilot.lua",
        config = function()
            require("copilot").setup({
                suggestion = {
                    auto_trigger = false
                },
                copilot_node_command = vim.fn.expand("$HOME") .. "/.asdf/installs/nodejs/22.20.0/bin/node"
            })

            local suggestion = require("copilot.suggestion")
            vim.keymap.set("n", "<leader>ct", function()
                suggestion.toggle_auto_trigger()
                vim.notify("copilot suggestion auto_trigger is: " .. tostring(vim.b.copilot_suggestion_auto_trigger), vim.log.levels.INFO)
            end)
            vim.keymap.set("i", "<C-l>", function()
                suggestion.accept()
            end)
            vim.keymap.set("i", "<C-j>", function()
                suggestion.next()
            end)
            vim.keymap.set("i", "<C-k>", function()
                suggestion.prev()
            end)
            vim.keymap.set("i", "<C-e>", function()
                suggestion.dismiss()
            end)

            vim.api.nvim_create_autocmd("InsertCharPre", {
                callback = function()
                    if (suggestion.is_visible()) then
                        suggestion.dismiss()
                    end
                end,
            })

            -- Dismiss when leaving insert mode
            vim.api.nvim_create_autocmd("InsertLeave", {
                callback = function()
                    if (suggestion.is_visible()) then
                        suggestion.dismiss()
                    end
                end,
            })
        end
    },
    {
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
                    http = {
                        qwen = function()
                            return require("codecompanion.adapters").extend("ollama", {
                                schema = {
                                    model = {
                                        default = "qwen2.5:14b",
                                    },
                                },
                            })
                        end,
                    }
                },
                strategies = {
                    chat = {
                        -- adapter = "qwen",
                    },
                    inline = {
                        -- adapter = "qwen"
                    }
                },
                display = {
                    action_palette = {
                        provider = "telescope"
                    },
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
}
