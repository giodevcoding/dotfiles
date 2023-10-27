local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.prettierd,
        --[[
        null_ls.builtins.diagnostics.eslint.with {
            condition = function(utils)
                return not utils.has_file '.pnp.cjs'
            end
        }
        ]]--
    }
})

local prettier = require("prettier")

prettier.setup({
    bin = 'prettier',
    filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
      },
})

vim.keymap.set("n", "<leader>pr", "<cmd>Prettier<CR>")
