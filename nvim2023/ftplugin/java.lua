local status_ok, jdtls = pcall(require, "jdtls");
if not status_ok then
    return
end

local home = vim.env.HOME
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/"
--local equinox_version = "1.6.500.v20230622-2056"
local equinox_version = "1.6.500.v20230717-2134"

WORKSPACE_PATH = home .. "/workspace/"
if vim.fn.has("mac") == 1 then
    OS_NAME = "mac"
elseif vim.fn.has("unix") == 1 then
    OS_NAME = "linux"
elseif vim.fn.has("win32") == 1 then
    OS_NAME = "win"
else
    vim.notify("Unsupported OS", vim.log.levels.WARN, { title = "Jdtls" })
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

function on_attach(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>vk", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>ve", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>va", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

local config = {
    cmd = {
        home .. "/.asdf/installs/java/corretto-17.0.4.9.1/bin/java", -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:/opt/lombok/lombok.jar",
        "-Xbootclasspath/a:/opt/lombok/lombok.jar",
        -- 💀
        "-jar",
        jdtls_path .. "plugins/org.eclipse.equinox.launcher_" .. equinox_version .. ".jar",
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version
        -- 💀
        "-configuration",
        jdtls_path .. "config_" .. OS_NAME,
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.

        "-data",
        workspace_dir,
    },
    capabilities = require("cmp_nvim_lsp").default_capabilities()
}

local keymap = vim.keymap.set

keymap("n", "<leader>vo", ":lua require'jdtls'.organize_imports()<cr>", { silent = true })
keymap("n", "<leader>vxv", ":lua require'jdtls'.extract_variable()<cr>", { silent = true })
keymap("v", "<leader>vxv", "<Esc>:lua require'jdtls'.extract_variable(true)<cr>", { silent = true })
keymap("n", "<leader>vxc", ":lua require'jdtls'.extract_constant()<cr>", { silent = true })
keymap("v", "<leader>vxc", "<Esc>:lua require'jdtls'.extract_constant(true)<cr>", { silent = true })
keymap("v", "<leader>vxm", "<Esc>:lua require'jdtls'.extract_method(true)<cr>", { silent = true })

vim.cmd [[
command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
command! -buffer JdtJol lua require('jdtls').jol()
command! -buffer JdtBytecode lua require('jdtls').javap()
command! -buffer JdtJshell lua require('jdtls').jshell()
]]

jdtls.start_or_attach(config)
