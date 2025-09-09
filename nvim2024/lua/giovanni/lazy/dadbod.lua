local db_username = "giovanni_panzetta"

local db_creds = {
    ECS_TEST_PASSWORD = {
        profile = "core-test/media-dev-elevated-test",
        cluster = "enterprise-services-cluster"
    },
    ECS_QA_PASSWORD = {
        profile = "core-qa/media-dev-elevated-qa",
        cluster = "enterprise-services-cluster"
    },
    ECS_PROD_PASSWORD = {
        profile = "core-prod/media-dev-elevated-prod",
        cluster = "enterprise-services-cluster"
    }
}

local NO_PROJECT_ROOT = "No project root found."

local function load_connections_file()
    local project_root = vim.fs.root(0, '.git')
    if project_root == nil then return NO_PROJECT_ROOT end
    local connections_file_path = project_root .. '/dbui-connections.json'

    if not vim.uv.fs_stat(connections_file_path) then
        return {}
    end

    local connection_file = io.open(connections_file_path, "r")
    if connection_file == nil then
        return {}
    end

    local content = connection_file:read("*a")
    connection_file:close()

    local connections_data = vim.json.decode(content)
    return connections_data
end


local function inject_passwords(name, url)
    local new_url = url
    local urlencode = require("giovanni.utils").urlencode

    for env_var, aws_data in pairs(db_creds) do
        local full_env_var = '$' .. env_var
        if string.find(new_url, full_env_var) then
            vim.notify("Fetching " .. full_env_var, vim.log.levels.INFO)
            local db_password = require("giovanni.functions").get_db_creds(db_username, aws_data.profile,
                aws_data.cluster)
            db_password = string.gsub(db_password, "\n", "")

            local encoded_password = urlencode(db_password):gsub("%%", "%%%%")
            new_url = new_url:gsub(full_env_var, encoded_password)
        end
    end


    return new_url
end

local function get_dbs(connections)
    local dbs = {}

    for _, connection in pairs(connections) do
        local wrapped_connection = {
            name = connection.name,
            url = function()
                return inject_passwords(connection.name, connection.url)
            end
        }
        table.insert(dbs, wrapped_connection)
    end

    return dbs
end

local function load_db_connections()
    local status, connections = pcall(load_connections_file)
    if connections == NO_PROJECT_ROOT then return end
    if not status then
        local err = connections -- value is error if status is false
        vim.notify('Could not load DB connections! ' .. err)
        return
    end

    vim.g.dbs = get_dbs(connections)
end

return {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod',                     lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        vim.g.db_ui_use_nerd_fonts = 1
        load_db_connections()
        vim.keymap.set("n", "<leader>db", ":DBUIToggle<CR>", { silent = true })
        vim.keymap.set('n', '<leader>dd', ":%DB<CR>", { silent = true })
        vim.keymap.set('x', '<leader>dd', "\"dy:DB <C-r>d;<CR>", { silent = true })
    end,
}
