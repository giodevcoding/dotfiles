require("telescope").setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "package-lock.json"
        },
    },
    extensions = {
        file_browser = {
        }
    }
}

require("telescope").load_extension "file_browser"
