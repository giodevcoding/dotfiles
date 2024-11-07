return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        build = "make install_jsregexp",

        config = function()
            local luasnip = require("luasnip")
            local snippet = luasnip.snippet
            local snippet_node = luasnip.snippet_node
            local text = luasnip.text_node
            local insert = luasnip.insert_node
            local func = luasnip.function_node
            local choice = luasnip.choice_node
            local dynamic = luasnip.dynamic_node
            local restore = luasnip.restore_node
            local lambda = require("luasnip.extras").lambda
            local rep = require("luasnip.extras").rep
            local partial = require("luasnip.extras").partial
            local match = require("luasnip.extras").match
            local nonempty = require("luasnip.extras").nonempty
            local dynamic_lambda = require("luasnip.extras").dynamic_lambda
            local fmt = require("luasnip.extras.fmt").fmt
            local fmta = require("luasnip.extras.fmt").fmta
            local types = require("luasnip.util.types")
            local conds = require("luasnip.extras.conditions")
            local conds_expand = require("luasnip.extras.conditions.expand")
        end
    }
}
