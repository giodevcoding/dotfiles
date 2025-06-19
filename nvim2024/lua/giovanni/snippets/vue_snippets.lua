local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

local setupSnippet = s("setup", {
    t({ '<script setup lang="ts">', '' }),
    i(0),
    t({ '', '</script>' })
})

luasnip.add_snippets("vue", {
    setupSnippet
})
