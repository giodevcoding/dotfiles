return {
    'nvim-java/nvim-java',
    lazy = false,
    priority = 100,
    config = function()
        require('java').setup()
        require('lspconfig').jdtls.setup {
            settings = {
                java = {
                    configuration = {
                        runtimes = {
                            {
                                name = "JavaASDF",
                                path = "$JAVA_HOME",
                                default = true
                            }
                        }
                    }
                }
            }
        }
    end
}
