local enabled_filetypes = { 'go', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'ruby', 'java', 'lua' }
-- Cannot get this to work. Gonna leave it in here, but give up on it for now.
--[[
return {
    'git@gitlab.com:gitlab-org/editor-extensions/gitlab.vim.git',
    event = { 'BufReadPre', 'BufNewFile' },
    ft = enabled_filetypes,
    cond = function()
        return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ''
    end,
    config = function()
        require('gitlab').setup {
            statusline = {
                enabled = true,
            },
            code_suggestions = {
                auto_filetypes = enabled_filetypes,
            }
        }
    end
}
]]--

return {}
