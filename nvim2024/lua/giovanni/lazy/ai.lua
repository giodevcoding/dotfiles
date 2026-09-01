return {
    {
        "ThePrimeagen/99",
        config = function()
            local _99 = require("99")
            local PiProvider = require("giovanni.pi_provider")

            -- register so it shows up in the <leader>9p provider picker
            _99.Providers.PiProvider = PiProvider

            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)
            local home = vim.fn.expand("~")

            local is_work = vim.fs.basename(home) == "giovanni.panzetta"

            local function get_provider_config()
                if is_work then
                    return _99.Providers.ClaudeCodeProvider, "claude-sonnet-4-6"
                end
                return PiProvider, "ollama-cloud/glm-5.3-flash"
            end

            local provider, model = get_provider_config()

            _99.setup({
                provider = provider,
                model = model,

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
                    "AGENT.md",
                    "AGENTS.md",
                },
            })

            -- Create your own short cuts for the different types of actions
            vim.keymap.set("n", "<leader>9s", function()
                _99.search()
            end)

            vim.keymap.set("n", "<leader>9v", function()
                _99.vibe()
            end)

            vim.keymap.set("n", "<leader>9o", function()
                _99.open()
            end)
            -- take extra note that i have visual selection only in v mode
            -- technically whatever your last visual selection is, will be used
            -- so i have this set to visual mode so i dont screw up and use an
            -- old visual selection
            --
            -- likely ill add a mode check and assert on required visual mode
            -- so just prepare for it now
            vim.keymap.set("v", "<leader>9v", function()
                _99.visual()
            end)

            vim.keymap.set("n", "<leader>9l", function()
                _99.view_logs()
            end)

            --- if you have a request you dont want to make any changes, just cancel it
            vim.keymap.set("n", "<leader>9x", function()
                _99.stop_all_requests()
            end)

            vim.keymap.set("n", "<leader>9m", function()
                require("99.extensions.telescope").select_model()
            end)

            vim.keymap.set("n", "<leader>9p", function()
                require("99.extensions.telescope").select_provider()
            end)
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
