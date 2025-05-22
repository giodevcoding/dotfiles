local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node

local function getPackage()
    local directory = vim.fn.expand("%:h")

    local mainSrcSegment = "src/main/java/"
    local testSrcSegment = "src/test/java/"

    local mainIndex = string.find(directory, mainSrcSegment)
    local testIndex = string.find(directory, testSrcSegment)

    if mainIndex == nil and testIndex == nil then
        return string.gsub(directory, "/", ".")
        --return ""
    end

    local subpath

    if mainIndex ~= nil then
        local mainLength = string.len(mainSrcSegment)
        subpath = string.sub(directory, mainIndex + mainLength)
    else
        local testLength = string.len(testSrcSegment)
        subpath = string.sub(directory, testIndex + testLength)
    end

    return string.gsub(subpath, "/", ".")
end

local function getClassName()
    return vim.fn.expand("%:t:r")
end

local function getPackageLine()
    return "package " .. getPackage() .. ";"
end

local function getPublicClassLine()
    return "public class " .. getClassName() .. " {"
end

local function getPublicInterfaceLine()
    return "public interface " .. getClassName() .. " {"
end

local newClassSnippet = s("newclass", {
    f(getPackageLine, {}),
    t({ "", "", "" }),
    f(getPublicClassLine, {}),
    t({ "", "    " }),
    i(0),
    t({ "", "}" })
})

local newInterfaceSnippet = s("newinterface", {
    f(getPackageLine, {}),
    t({ "", "", "" }),
    f(getPublicInterfaceLine, {}),
    t({ "", "    " }),
    i(0),
    t({ "", "}" })
})

local newControllerSnippet = s("newcontroller", {
    f(getPackageLine, {}),
    t({ "", "", "" }),
    t({ "import org.springframework.stereotype.Controller;", "", "" }),
    t({"@Controller", ""}),
    f(getPublicClassLine, {}),
    t({ "", "    " }),
    i(0),
    t({ "", "}" })
})

local newServiceSnippet = s("newservice", {
    f(getPackageLine, {}),
    t({ "", "", "" }),
    t({ "import org.springframework.stereotype.Service;", "", "" }),
    t({"@Service", ""}),
    f(getPublicClassLine, {}),
    t({ "", "    " }),
    i(0),
    t({ "", "}" })
})

local newGetMappingSnippet = s("newgetmapping", {
    t("@GetMapping(\""),
    i(1),
    t({"\")", "public ResponseEntity<"}),
    i(2),
    t({">("}),
    i(3),
    t({") {", "    "}),
    i(0),
    t({"", "}"})

})

local newPostMappingSnippet = s("newpostmapping", {
    t("@PostMapping(\""),
    i(1),
    t({"\")", "public ResponseEntity<"}),
    i(2),
    t(">"),
    i(3),
    t("("),
    i(4),
    t({") {", "    "}),
    i(0),
    t({"", "}"})

})

luasnip.add_snippets("java", {
    newClassSnippet,
    newInterfaceSnippet,
    newControllerSnippet,
    newServiceSnippet,
    newGetMappingSnippet,
    newPostMappingSnippet
})
