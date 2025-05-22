return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local lspconfig = require("lspconfig")
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        local add_keymappings_on_attach = require("giovanni.functions").add_keymappings_on_attach

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                'lua_ls',
                'ts_ls',
                'eslint',
                'gopls',
                'jdtls'
            },
            automatic_enable = {
                exclude = {
                    'jdtls',
                    'lua_ls',
                    'ts_ls',
                    'volar',
                    'html'
                }
            }
        })

        vim.lsp.config("*", {
            capabilities = capabilities,
            on_attach = add_keymappings_on_attach
        })

        lspconfig.lua_ls.setup {
            capabilities = capabilities,
            on_attach = add_keymappings_on_attach,
            settings = {
                Lua = {
                    runtime = { version = "Lua 5.1" },
                    diagnostics = {
                        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                    }
                }
            }
        }
        lspconfig.ts_ls.setup {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                add_keymappings_on_attach(client, bufnr)
                vim.keymap.set("n", "<leader>vo",
                    function() vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } }) end,
                    {})
            end,
            on_new_config = function(new_config, new_root_dir)
                new_config.init_options.plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vim.fn.stdpath 'data' ..
                            '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                        languages = { 'vue' },
                    }
                }
            end
        }
        lspconfig.volar.setup {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                add_keymappings_on_attach(client, bufnr)
                vim.keymap.set("n", "<leader>vo",
                    function() vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } }) end,
                    {})
            end,
            init_options = {
                vue = {
                    hybridMode = false,
                }
            },
            settings = {
                vue = {
                    complete = {
                        casing = {
                            tags = "kebab",
                            props = "kebab"
                        }
                    }
                }
            }
        }
        lspconfig.html.setup {
            capabilities = capabilities,
            filetypes = { "html", "templ", "gohtml", "gotmpl" },
        }

        local luasnip = require('luasnip')

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
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
                        cmp.select_next_item({
                            behavior = cmp.SelectBehavior.Select
                        })
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({
                            behavior = cmp.SelectBehavior.Select
                        })
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' }
            })
        })
    end
}
