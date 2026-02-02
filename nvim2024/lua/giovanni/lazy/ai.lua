local utils = require("giovanni.utils")
return {
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        opts = {
            terminal = {
                provider = "native",
                provider_opts = {
                    external_terminal_cmd = function(cmd, env)
                        print (utils.dump(env))
                        return "tmux split-window -h -l 30% -c " .. vim.fn.getcwd() .. ' ' .. cmd
                    end
                }
            }
        },
        keys = {
            { "<leader>c",  nil,                              desc = "AI/Claude Code" },
            { "<leader>cc", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
            { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
            { "<leader>cr", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
            { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
            { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
            {
                "<leader>cs",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
            },
            -- Diff management
            { "<leader>cy", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>cn", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
        },
    },
    {
        "olimorris/codecompanion.nvim",
        enabled = false,
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
                    },
                    acp = {
                        claude_code = function()
                            return require("codecompanion.adapters").extend("claude_code", {
                                env = {
                                    CLAUDE_CODE_OAUTH_TOKEN = os.getenv("CLAUDE_CODE_OAUTH_TOKEN")
                                }
                            });
                        end
                    }
                },
                strategies = {
                    chat = {
                        adapter = "claude_code",
                        -- adapter = "qwen",
                    },
                    inline = {
                        adapter = "claude_code",
                        -- adapter = "qwen"
                    },
                    cmd = {
                        adapter = "claude_code"
                    }
                },
                display = {
                    action_palette = {
                        provider = "telescope"
                    },
                    diff = {
                        enabled = true,
                        provider = "mini_diff"
                    },
                    chat = {
                        window = {
                            position = 'right',
                            width = 0.3
                        }
                    }
                }
            })
            vim.keymap.set("n", "<leader>cc", function() vim.cmd [[ CodeCompanionChat Toggle ]] end)
            vim.keymap.set("n", "<leader>cn", function() vim.cmd [[ CodeCompanionChat ]] end)
            vim.keymap.set("n", "<leader>ci", ":CodeCompanion ")
            vim.keymap.set("v", "<leader>ci", ":CodeCompanion ")
            vim.keymap.set("n", "<leader>ca", function() vim.cmd [[ CodeCompanionActions ]] end)
            vim.keymap.set("v", "<leader>ca", function() vim.cmd [[ CodeCompanionActions ]] end)
            vim.keymap.set("v", "<leader>ce", function() codecompanion.prompt("explain") end)
        end
    }
}
