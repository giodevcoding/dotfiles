return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        build = "make install_jsregexp",

        config = function()
            require("giovanni.snippets.java_snippets")
            require("giovanni.snippets.vue_snippets")
        end
    }
}
