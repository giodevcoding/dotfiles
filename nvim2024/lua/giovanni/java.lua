local M = {}

function M.create_test()
    local path = vim.api.nvim_buf_get_name(0)
    local main_marker = "/src/main/java/"
    local start_idx = path:find(main_marker, 1, true)
    if not start_idx then
        vim.notify("not under src/main/java", vim.log.levels.ERROR)
        return
    end

    local root = path:sub(1, start_idx - 1)
    local rel = path:sub(start_idx + #main_marker)

    local dir = vim.fn.fnamemodify(rel, ":h")
    local filename = vim.fn.fnamemodify(rel, ":t:r")
    local test_filename = filename .. "Test.java"

    local test_dir = root .. "/src/test/java/" .. dir
    local test_path = test_dir .. "/" .. test_filename

    vim.fn.mkdir(test_dir, "p")

    if vim.fn.filereadable(test_path) == 0 then
        local package = dir:gsub("/", ".")
        local lines = {
            "package " .. package .. ";",
            "",
            "class " .. filename .. "Test {",
            "",
            "}",
            "",
        }
        vim.fn.writefile(lines, test_path)
    end

    vim.cmd("edit " .. vim.fn.fnameescape(test_path))
end

local method_types = {
    method_declaration = true,
    constructor_declaration = true,
}

local class_types = {
    class_declaration = true,
    interface_declaration = true,
    enum_declaration = true,
    record_declaration = true,
}

function M.cursor_on_class(bufnr)
    local ok, node = pcall(vim.treesitter.get_node, { bufnr = bufnr })
    if not ok or not node then
        return false
    end

    while node do
        if method_types[node:type()] then
            return false
        end
        if class_types[node:type()] then
            return true
        end
        node = node:parent()
    end

    return false
end

function M.code_action_with_extras()
    local bufnr = vim.api.nvim_get_current_buf()
    local params = vim.lsp.util.make_range_params()
    params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr) }

    local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000) or {}

    local items = {}
    if M.cursor_on_class(bufnr) then
        table.insert(items, { title = "Create Test Class", is_custom = true })
    end
    for client_id, res in pairs(results) do
        for _, action in ipairs(res.result or {}) do
            table.insert(items, { title = action.title, action = action, client_id = client_id })
        end
    end

    vim.ui.select(items, {
        prompt = "Code actions",
        format_item = function(item) return item.title end,
    }, function(choice)
        if not choice then
            return
        end
        if choice.is_custom then
            M.create_test()
            return
        end

        local client = vim.lsp.get_client_by_id(choice.client_id)
        local action = choice.action

        local function apply(resolved_action)
            if resolved_action.edit or (resolved_action.command and type(resolved_action.command) ~= "table") then
                vim.lsp.util.apply_workspace_edit(resolved_action.edit, client.offset_encoding)
            end
            if resolved_action.command then
                local command = type(resolved_action.command) == "table" and resolved_action.command or resolved_action
                client.request("workspace/executeCommand", command)
            end
        end

        if not action.edit and client.supports_method("codeAction/resolve") then
            client.request("codeAction/resolve", action, function(err, resolved)
                apply(err and action or resolved)
            end)
        else
            apply(action)
        end
    end)
end

return M
