return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install {
            "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "php", "vue", "java"
        }

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "javascript", "typescript", "c", "lua",
                "vim", "vimdoc", "query", "php", "gotmpl", "vue",
                "java"
            },
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })

        vim.filetype.add({
            extension = {
                gohtml = "gotmpl"
            }
        })
    end
}
