local function saveAllJavaBuffers()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
            local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
            if filetype == 'java' then
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd('w')
                end)
            end
        end
    end
end

local function reloadAllJavaBuffers()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
            local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
            if filetype == 'java' then
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd('e!')
                end)
            end
        end
    end
end

return {
    {
        "mhartington/formatter.nvim",
        config = function()
            require("formatter").setup {
                filetype = {
                    javascript = {
                        require("formatter.filetypes.javascript").prettierd
                    },
                    javascriptreact = {
                        require("formatter.filetypes.javascriptreact").prettierd
                    },
                    typescript = {
                        require("formatter.filetypes.typescript").prettierd
                    },
                    typescriptreact = {
                        require("formatter.filetypes.typescriptreact").prettierd
                    },
                    vue = {
                        require("formatter.filetypes.vue").prettierd
                    },
                    svelte = {
                        require("formatter.filetypes.javascript").prettierd
                    },
                    java = {
                        function()
                            return {
                                exe = 'mvn',
                                args = {
                                    'spotless:apply'
                                },
                                stdin = false,
                                no_append = true,
                            }
                        end
                    }
                }
            }
            vim.keymap.set("n", "<leader>pr", vim.cmd.FormatLock)

            vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
            vim.api.nvim_create_autocmd("User", {
                pattern = "FormatterPre",
                group = "FormatAutogroup",
                callback = function()
                    saveAllJavaBuffers()
                    return true
                end
            })
            vim.api.nvim_create_autocmd("User", {
                pattern = "FormatterPost",
                group = "FormatAutogroup",
                callback = function()
                    reloadAllJavaBuffers()
                end
            })
        end
    },
    "nvim-tree/nvim-web-devicons",
    "mattn/emmet-vim",
    "tpope/vim-surround",
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    -- Defaults
                    enable_close = true,         -- Auto close tags
                    enable_rename = true,        -- Auto rename pairs of tags
                    enable_close_on_slash = true -- Auto close on trailing </
                },
            })
        end
    },
    {
        'preservim/vim-markdown',
        dependencies = { 'godlygeek/tabular' }
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
}
