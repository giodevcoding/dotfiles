return {
    {
        "mason-org/mason.nvim",
        config = false
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp",
            "j-hui/fidget.nvim",
        },
        config = function()
            local cmp_lsp = require("cmp_nvim_lsp")

            local add_keymappings_on_attach = require("giovanni.functions").add_keymappings_on_attach
            local lsp_capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())

            vim.lsp.config("*", {
                capabilities = lsp_capabilities,
                on_attach = add_keymappings_on_attach
            })

            vim.lsp.config('lua_ls', {
                capabilities = lsp_capabilities,
                on_attach = add_keymappings_on_attach,
                settings = {
                    Lua = {
                        runtime = { version = "Lua 5.1" },
                        diagnostics = {
                            globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                        }
                    }
                }
            })

            vim.lsp.config('ts_ls', {
                capabilities = lsp_capabilities,
                on_attach = function(client, bufnr)
                    add_keymappings_on_attach(client, bufnr)
                    vim.keymap.set("n", "<leader>vo",
                        function() vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } }) end,
                        {})
                end,
                init_options = {
                    plugins = {
                        {
                            name = '@vue/typescript-plugin',
                            location = vim.fn.stdpath 'data' ..
                                '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                            languages = { 'vue' },
                        }
                    }
                }
            })

            vim.lsp.config('vue_ls', {
                capabilities = lsp_capabilities,
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
            })

            vim.lsp.config('html', {
                capabilities = lsp_capabilities,
                filetypes = { "html", "templ", "gohtml", "gotmpl" },
            })

            require("mason").setup {
                registries = {
                    "github:nvim-java/mason-registry",
                    "github:mason-org/mason-registry",
                },
            }
            require("mason-lspconfig").setup {
                ensure_installed = {
                    'lua_ls',
                    'ts_ls',
                    'eslint',
                    'gopls',
                },
            }
        end
    },
    {

        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            local cmp = require("cmp")
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
                                local entry = cmp.get_selected_entry()
                                if not entry then
                                    fallback()
                                else
                                    cmp.confirm({
                                        select = false,
                                    })
                                end
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
                    ['<C-e>'] = cmp.mapping(function(fallback)
                        if (cmp.visible()) then
                            cmp.close()
                        else
                            fallback()
                        end
                    end)
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
}
