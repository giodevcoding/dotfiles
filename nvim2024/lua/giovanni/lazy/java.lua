local functions = require('giovanni.functions')

local home = os.getenv('HOME')

return {
    {
        'mfussenegger/nvim-jdtls',
    },
    --[[{
        'nvim-java/nvim-java',
        config = function()
            require('java').setup()
            require('lspconfig').jdtls.setup({
                on_attach = function ()
                    functions.add_keymappings_on_attach()
                end,
                settings = {
                    java = {
                        configuration = {
                            runtimes = {
                                {
                                    name = 'JavaSE-21',
                                    path = home .. '/.asdf/installs/java/corretto-21.0.5.11.1',
                                    default = true,
                                }
                            }
                        }
                    }
                }
            })
        end
    }]]
}
