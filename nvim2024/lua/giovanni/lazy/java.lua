local home = os.getenv("HOME")

local spring_extension_path = home .. '/.local/share/nvim/mason/packages/spring-boot-tools/extension'

local ls_path = vim.fn.glob(spring_extension_path .. '/language-server/spring-boot-language-server-*.jar')

return {
    'mfussenegger/nvim-jdtls',
    {
        "JavaHello/spring-boot.nvim",
        dependencies = {
            'mfussenegger/nvim-jdtls',
        },
        opts = {
            ls_path = ls_path,
        },
    }
}
