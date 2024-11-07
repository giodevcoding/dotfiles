local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')
require('mason-lspconfig').setup()
local is_windows = require("giovanni.functions").is_windows

lsp.preset('recommended')

lsp.ensure_installed({
    'ts_ls',
    'eslint',
    'lua_ls',
})


lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>vk", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>ve", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>va", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>vq", vim.cmd.LspRestart, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    --[[ Primeagens bindings
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnositc.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	]]--

    if (client.name == "tsserver" or client.name == 'ts_ls') then
        vim.keymap.set("n", "<leader>vo", function () vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}}) end, opts)
    end
end)

lspconfig.volar.setup{
  filetypes = {'vue', 'typescript', 'javascript'},
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
        tsdk = vim.fn.getcwd() .. "node_modules/typescript/lib"
    }
  },
}

lspconfig.intelephense.setup({
    settings = {
        intelephense = {
            files = {
                maxSize = 1000000,
            },
            stubs = {
                "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date", "dba", "dom",
                "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext", "gmp", "hash", "iconv",
                "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli", "oci8", "odbc", "openssl",
                "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix",
                "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium",
                "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer",
                "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib", "wordpress", "phpunit",
            },
            diagnostics = {
                enable = true,
            },
        }
    }
})

lspconfig.solargraph.setup({
    filetypes = { "ruby", "rakefile" },
    root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
    settings = {
        solargraph = {
            autoformat = false,
            formatting = true,
            completion = true,
            diagnostic = true,
            folding = true,
            references = true,
            rename = true,
            symbols = true
        }
    }
})

lsp.skip_server_setup({ 'jdtls' })

local nc_command = 'nc'

if (is_windows()) then
    nc_command = 'ncat'
end

lspconfig.gdscript.setup({
    cmd = { nc_command, 'localhost', '6005' },
    root_dir = function() return vim.fn.getcwd() end
})

lspconfig.sourcekit.setup {
    cmd = { '/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp' },
    filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp", "objcpp", "objc" },
}

-- Not needed due to using flutter-tools.nvim
-- lspconfig.dartls.setup({})

lsp.setup()

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    mapping = {
    ['<CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            if luasnip.expandable() then
                luasnip.expand()
            else
                cmp.confirm({
                    select = true,
                })
            end
        else
            fallback()
        end
    end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),}
})
