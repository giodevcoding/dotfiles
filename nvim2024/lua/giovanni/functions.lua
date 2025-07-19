local M = {}

function M.add_keymappings_on_attach(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>vk", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>ve", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>va", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>vq", vim.cmd.LspRestart, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)
end

function M.get_db_creds(db_username, aws_profile, rds_cluster)
    local get_db_creds_script = vim.fn.stdpath('config') .. '/scripts/get-db-creds'
    return vim.fn.system({ get_db_creds_script, db_username, aws_profile, rds_cluster })
end

return M
