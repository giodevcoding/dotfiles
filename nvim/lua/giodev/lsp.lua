local lsp = require "lspconfig"
local coq = require "coq"

-- VUE (VOLAR)
lsp.volar.setup(coq.lsp_ensure_capabilities({
    filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
    init_options = {
        typescript = {
            tsdk = '/usr/local/lib/node_modules/typescript/lib'
        },
    }
}))


-- ESLint
-- DISABLED FOR NOW BECAUSE NO IDEA HOW TO FIX THE INDENT MESSAGES
--[[
lsp.eslint.setup(coq.lsp_ensure_capabilities({
    settings = {
        format = false,
    }
}))
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    { pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" }, command = "EslintFixAll" }
)
]]--

-- CSS
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp.cssls.setup (coq.lsp_ensure_capabilities({
    capabilities = capabilities    
}))

-- Tailwind BASICALLY WILL NOT WORK
-- lsp.tailwindcss.setup(coq.lsp_ensure_capabilities())

-- Emmet
lsp.emmet_ls.setup(coq.lsp_ensure_capabilities({}))

-- Python
lsp.pyright.setup(coq.lsp_ensure_capabilities())

lsp.lua_ls.setup(coq.lsp_ensure_capabilities())

-- PHP --
lsp.intelephense.setup(coq.lsp_ensure_capabilities({
    settings = {
        intelephense = {
            stubs = {
                "bcmath",
                "bz2",
                "calendar",
                "Core",
                "curl",
                "zip",
                "zlib",
                "wordpress",
                "woocommerce",
                "acf-pro",
                "wordpress-globals",
                "wp-cli",
                "genesis",
                "polylang"
            },
            environment = {
                includePaths = "~/.config/composer/vendor/php-stubs/"
            },
            files = {
                masxSize = 5000000;
            };
        };
    }
}))
