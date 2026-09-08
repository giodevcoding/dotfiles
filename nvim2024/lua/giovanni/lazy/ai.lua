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
                    return _99.Providers.ClaudeCodeProvider, "claude-sonnet-5"
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

                tmp_dir = "./.99",

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
        "carlos-algms/agentic.nvim",
        enabled = function()
            local home = vim.fn.expand("~")
            local is_work = vim.fs.basename(home) == "giovanni.panzetta"
            return not is_work
        end,
        opts = function()
            return {
                provider = "pi-acp",
                acp_providers = {
                    ["pi-acp"] = {
                        command = "node",
                        args = { vim.fn.expand("~/code/pi-acp/dist/index.js") },
                    },
                },
                keymaps = {
                    widget = {
                        switch_model = "<leader>am",
                    },
                },
            }
        end,
        keys = {
            {
                "<leader>ao",
                function() require("agentic").open({ auto_add_to_context = false, focus_prompt = false }) end,
                mode = { "n", "v" },
                desc = "Open Agentic Chat"
            },
            {
                "<leader>ac",
                function() require("agentic").toggle({ auto_add_to_context = false, focus_prompt = false }) end,
                mode = { "n", "v" },
                desc = "Toggle Agentic Chat"
            },
            {
                "<leader>ai",
                function() require("agentic").open({ auto_add_to_context = false, focus_prompt = true }) end,
                mode = { "n", "v" },
                desc = "Focus Agentic Chat (open if needed)"
            },
            {
                "<leader>af",
                function() require("agentic").add_selection_or_file_to_context() end,
                mode = { "n", "v" },
                desc = "Add file or selection to Agentic to Context"
            },
            {
                "<leader>an",
                function() require("agentic").new_session() end,
                mode = { "n", "v" },
                desc = "New Agentic Session"
            },
            {
                "<leader>ar", -- ai Restore
                function()
                    require("agentic").restore_session()
                end,
                desc = "Agentic Restore session",
                silent = true,
                mode = { "n", "v" },
            },
            {
                "<leader>ad",
                function()
                    require("agentic").add_current_line_diagnostics()
                end,
                desc = "Add current line diagnostic to Agentic",
                mode = { "n" },
            },
            {
                "<leader>aD",
                function()
                    require("agentic").add_buffer_diagnostics()
                end,
                desc = "Add all buffer diagnostics to Agentic",
                mode = { "n" },
            },
            {
                "<leader>ax",
                function()
                    require("agentic").stop_generation()
                end,
                desc = "Stop Agentic generation",
                mode = { "n", "v" },
            },
            {
                "<leader>as",
                function()
                    require("agentic").select_session()
                end,
                desc = "Select Agentic session",
                mode = { "n", "v" },
            },
            {
                "<leader>a]",
                function()
                    require("agentic").next_session()
                end,
                desc = "Next Agentic session",
                mode = { "n", "v" },
            },
            {
                "<leader>a[",
                function()
                    require("agentic").prev_session()
                end,
                desc = "Previous Agentic session",
                mode = { "n", "v" },
            },
            {
                "<leader>aP",
                function()
                    require("agentic").new_session_with_provider()
                end,
                desc = "New Agentic session with provider picker",
                mode = { "n", "v" },
            },
            {
                "<leader>ap",
                function()
                    require("agentic").switch_provider()
                end,
                desc = "Switch Agentic provider",
                mode = { "n", "v" },
            },
            {
                "<leader>al",
                function()
                    require("agentic").rotate_layout()
                end,
                desc = "Rotate Agentic layout",
                mode = { "n", "v" },
            },
            {
                "<leader>aX",
                function()
                    require("agentic").destroy_session()
                end,
                desc = "Destroy Agentic session",
                mode = { "n", "v" },
            },
        },
        config = function(_, opts)
            require("agentic").setup(opts)

            -- Double-<Esc> in normal mode, in any Agentic window, stops generation
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "Agentic*",
                callback = function(args)
                    if args.match == "AgenticChat" then
                        pcall(vim.treesitter.start, args.buf, "markdown")
                    end

                    local last_esc = 0
                    vim.keymap.set("n", "<Esc>", function()
                        local now = vim.uv.now()
                        if now - last_esc < 400 then
                            require("agentic").stop_generation()
                            last_esc = 0
                        else
                            last_esc = now
                        end
                    end, { buffer = args.buf, desc = "Double-Esc: stop Agentic generation" })
                end,
            })
        end,
    },
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        cond = function()
            local home = vim.fn.expand("~")
            return vim.fs.basename(home) == "giovanni.panzetta"
        end,
        opts = {
            terminal = {
                provider = "native",
            },
            diff_opts = {
                layout = "unified",
                auto_resize_terminal = false,
            },
        },
        config = function(_, opts)
            require("claudecode").setup(opts)

            -- `auto_resize_terminal = false` stops the plugin from resizing the
            -- terminal itself, but the diff layout still runs `wincmd =` which
            -- equalizes all splits regardless. winfixwidth is the only thing
            -- that survives that.
            vim.api.nvim_create_autocmd("TermOpen", {
                pattern = "*",
                callback = function(args)
                    if vim.api.nvim_buf_get_name(args.buf):match("claude") then
                        vim.schedule(function()
                            local win = vim.fn.bufwinid(args.buf)
                            if win ~= -1 then
                                vim.wo[win].winfixwidth = true
                            end
                        end)
                    end
                end,
            })

            -- Auto-enter terminal-insert mode whenever the Claude Code buffer
            -- gets focus (window switch, not just on open).
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "*",
                callback = function(args)
                    if vim.bo[args.buf].buftype == "terminal" and vim.api.nvim_buf_get_name(args.buf):match("claude") then
                        vim.cmd("startinsert")
                    end
                end,
            })
        end,
        keys = {
            {
                "<leader>ao",
                function() require("claudecode.terminal").ensure_visible() end,
                mode = { "n", "v" },
                desc = "Open Claude Code (no focus)",
            },
            {
                "<leader>ac",
                function() require("claudecode.terminal").toggle({ focus = false }) end,
                mode = { "n", "v" },
                desc = "Toggle Claude Code (no focus)",
            },
            {
                "<leader>ai",
                "<cmd>ClaudeCodeFocus<cr>",
                mode = { "n", "v" },
                desc = "Focus Claude Code (open if needed)",
            },
            {
                "<leader>af",
                "<cmd>ClaudeCodeSend<cr>",
                mode = { "v" },
                desc = "Send selection to Claude Code",
            },
            {
                "<leader>af",
                "<cmd>ClaudeCodeAdd %<cr>",
                mode = { "n" },
                desc = "Add current file to Claude Code",
            },
            {
                "<leader>an",
                function()
                    vim.cmd("ClaudeCodeStop")
                    vim.cmd("ClaudeCode")
                end,
                mode = { "n", "v" },
                desc = "New Claude Code session",
            },
            {
                "<leader>ar",
                "<cmd>ClaudeCode --resume<cr>",
                desc = "Claude Code Resume session",
                silent = true,
                mode = { "n", "v" },
            },
            {
                "<leader>ad", -- ai Diagnostics
                function()
                    local d = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
                    if vim.tbl_isempty(d) then
                        vim.notify("No diagnostics on current line", vim.log.levels.WARN)
                        return
                    end
                    local lines = {}
                    for _, item in ipairs(d) do
                        table.insert(lines, string.format("%s:%d: %s", vim.fn.expand("%"), item.lnum + 1, item.message))
                    end
                    require("claudecode.terminal").send_to_terminal(table.concat(lines, "\n"), { submit = false })
                end,
                desc = "Add current line diagnostic to Claude Code",
                mode = { "n" },
            },
            {
                "<leader>aD", -- ai all Diagnostics
                function()
                    local d = vim.diagnostic.get(0)
                    if vim.tbl_isempty(d) then
                        vim.notify("No diagnostics in buffer", vim.log.levels.WARN)
                        return
                    end
                    local lines = {}
                    for _, item in ipairs(d) do
                        table.insert(lines, string.format("%s:%d: %s", vim.fn.expand("%"), item.lnum + 1, item.message))
                    end
                    require("claudecode.terminal").send_to_terminal(table.concat(lines, "\n"), { submit = false })
                end,
                desc = "Add all buffer diagnostics to Claude Code",
                mode = { "n" },
            },
            {
                "<leader>ax",
                function()
                    vim.notify("claudecode.nvim: no stop-generation API; use Ctrl-C in terminal", vim.log.levels.WARN)
                end,
                desc = "Stop Claude Code generation (unsupported)",
                mode = { "n", "v" },
            },
        },
    },
}
