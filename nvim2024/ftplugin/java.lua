local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")

local functions = require("giovanni.functions")
local home = os.getenv("HOME")
local java_home = os.getenv("JAVA_HOME")

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls_setup.find_root(root_markers)
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace" .. project_name

local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages"

local path_to_jdtls = path_to_mason_packages .. "/jdtls"

local path_to_config = path_to_jdtls .. "/config_mac"

local function get_lombok_path()
    local lombok_dir = home .. '/.m2/repository/org/projectlombok/lombok/'
    local lombok_versions = io.popen('ls -1 "' .. lombok_dir .. '" | sort -r')
    if lombok_versions ~= nil then
        local lb_i, lb_versions = 0, {}
        for lb_version in lombok_versions:lines() do
            lb_i = lb_i + 1
            lb_versions[lb_i] = lb_version
        end
        lombok_versions:close()
        if next(lb_versions) ~= nil then
            return vim.fn.expand(string.format('%s%s/*.jar', lombok_dir, lb_versions[1]))
        end
    end
    return ''
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
    cmd = {

        'java',

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',

        '-javaagent:' .. get_lombok_path(),

        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar', vim.fn.glob(path_to_jdtls .. "/plugins/org.eclipse.equinox.launcher_*.jar"),

        '-configuration', path_to_config,

        '-data', workspace_dir
    },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    on_attach = function()
        functions.add_keymappings_on_attach()
    end,
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = 'interactive',
                runtimes = {
                    {
                        name = "JavaSE-21",
                        path = java_home,
                        default = true
                    }
                }
            },
            maven = {
                downloadSources = true
            },
            references = {
                includeDecompiledSources = true
            },
        },
        extendedClientCapabilities = extendedClientCapabilities
    }
}

jdtls.start_or_attach(config)
