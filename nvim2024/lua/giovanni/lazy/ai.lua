local utils = require("giovanni.utils")
return {
    {
        "ThePrimeagen/99",
        config = function()
            local _99 = require("99")

            -- For logging that is to a file if you wish to trace through requests
            -- for reporting bugs, i would not rely on this, but instead the provided
            -- logging mechanisms within 99.  This is for more debugging purposes
            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)
            _99.setup({
                provider = _99.Providers.ClaudeCodeProvider,
                model = "claude-opus-4-5",

                logger = {
                    level = _99.DEBUG,
                    path = "/tmp/" .. basename .. ".99.debug",
                    print_on_error = true,
                },

                --- A new feature that is centered around tags
                completion = {
                    --- Defaults to .cursor/rules
                    -- I am going to disable these until i understand the
                    -- problem better.  Inside of cursor rules there is also
                    -- application rules, which means i need to apply these
                    -- differently
                    -- cursor_rules = "<custom path to cursor rules>"

                    --- A list of folders where you have your own SKILL.md
                    --- Expected format:
                    --- /path/to/dir/<skill_name>/SKILL.md
                    ---
                    --- Example:
                    --- Input Path:
                    --- "scratch/custom_rules/"
                    ---
                    --- Output Rules:
                    --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
                    --- ... the other rules in that dir ...
                    ---
                    custom_rules = {
                        "scratch/custom_rules/",
                    },

                    --- What autocomplete do you use.  We currently only
                    --- support cmp right now
                    source = "cmp",
                },

                --- WARNING: if you change cwd then this is likely broken
                --- ill likely fix this in a later change
                ---
                --- md_files is a list of files to look for and auto add based on the location
                --- of the originating request.  That means if you are at /foo/bar/baz.lua
                --- the system will automagically look for:
                --- /foo/bar/AGENT.md
                --- /foo/AGENT.md
                --- assuming that /foo is project root (based on cwd)
                md_files = {
                    "CLAUDE.md",
                },
            })

            -- Create your own short cuts for the different types of actions
            vim.keymap.set("n", "<leader>9f", function()
                _99.fill_in_function()
            end)
            vim.keymap.set("n", "<leader>9pf", function()
                _99.fill_in_function_prompt()
            end)
            -- take extra note that i have visual selection only in v mode
            -- technically whatever your last visual selection is, will be used
            -- so i have this set to visual mode so i dont screw up and use an
            -- old visual selection
            --
            -- likely ill add a mode check and assert on required visual mode
            -- so just prepare for it now
            vim.keymap.set("v", "<leader>9f", function()
                _99.visual()
            end)
            vim.keymap.set("v", "<leader>9pf", function()
                _99.visual_prompt()
            end)

            --- if you have a request you dont want to make any changes, just cancel it
            vim.keymap.set("v", "<leader>9x", function()
                _99.stop_all_requests()
            end)

            --- Example: Using rules + actions for custom behaviors
            --- Create a rule file like ~/.rules/debug.md that defines custom behavior.
            --- For instance, a "debug" rule could automatically add printf statements
            --- throughout a function to help debug its execution flow.
            -- vim.keymap.set("n", "<leader>9fd", function()
            --     _99.fill_in_function()
            -- end)
        end,
    },
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        opts = {
            terminal = {
                provider = "external",
                provider_opts = {
                    external_terminal_cmd = function(cmd, env)
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
