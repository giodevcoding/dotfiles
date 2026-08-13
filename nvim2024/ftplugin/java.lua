local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")

local functions = require("giovanni.functions")
local home = os.getenv("HOME")

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls_setup.find_root(root_markers)

-- submodule (e.g. backend/pom.xml) matches before parent .git repo root.
-- prefer the git repo root when one exists further up, so cache workspace
-- and jdtls root cover the whole repo, not just the submodule.
local git_root = vim.fs.dirname(vim.fs.find(".git", { path = root_dir, upward = true })[1])
if git_root then
    root_dir = git_root
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages"

local path_to_jdtls = path_to_mason_packages .. "/jdtls"

local path_to_config = path_to_jdtls .. "/config_mac"

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local java_exec = vim.fn.glob('~/.local/share/mise/installs/java/corretto-23.0.2.7.1/bin/java')
local jdtls_jar = vim.fn.glob(path_to_jdtls .. '/plugins/org.eclipse.equinox.launcher_*.jar')

local jdtls_config = {
    cmd = {
        java_exec,

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',

        '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/lombok-nightly/lombok.jar',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar', jdtls_jar,

        '-configuration', path_to_config,

        '-data', workspace_dir
    },
    root_dir = root_dir,
    on_attach = function()
        functions.add_keymappings_on_attach()
    end,
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSources = true
            },
            references = {
                includeDecompiledSources = true
            },
        },
        extendedClientCapabilities = extendedClientCapabilities
    },
    init_options = {
        bundles = {
            vim.fn.glob(
                home ..
                '/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar',
                1)
        }
    }
}

local spring_boot = require("spring_boot")

vim.list_extend(jdtls_config.init_options.bundles, spring_boot.java_extensions())

jdtls.start_or_attach(jdtls_config)
