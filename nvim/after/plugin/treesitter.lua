local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "comment", "jsdoc" },
    highlight = {
        enable = true,
        disable = { "" },
    },
    indent = {
        enable = true,
        disable = { "" },
    },
}
