return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end, {})
            vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>pe', builtin.diagnostics, {})
            vim.keymap.set('n', '<leader>cs', builtin.colorscheme, {})
            vim.keymap.set('n', '<leader>pc', function() vim.cmd [[TodoTelescope]] end, {})

            local telescope = require("telescope")
            local telescopeConfig = require("telescope.config")

            local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

            -- I want to search in hidden/dot files.
            table.insert(vimgrep_arguments, "--hidden")
            -- I don't want to search in the `.git` directory.
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")

            telescope.setup({
                defaults = {
                    path_display = { "truncate" },

                    -- `hidden = true` is not supported in text grep commands.
                    vimgrep_arguments = vimgrep_arguments,
                },
                pickers = {
                    buffers = {
                        mappings = {
                            n = {
                                ['d'] = require('telescope.actions').delete_buffer
                            },
                            i = {
                                ['<A-d>'] = require('telescope.actions').delete_buffer
                            }
                        }
                    },
                    find_files = {
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    },
                    live_grep = {
                        hidden = true
                    }
                },
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                        hidden = {
                            file_browser = true,
                            folder_browser = true
                        },
                        mappings = {
                        },
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            })

            telescope.load_extension("file_browser")
            telescope.load_extension("dap")
            telescope.load_extension("ui-select")
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            vim.keymap.set("n", "<leader>pt", "<cmd>Telescope file_browser<CR>")
            vim.keymap.set("n", "<leader>pv", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>")
        end
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
    },
}
