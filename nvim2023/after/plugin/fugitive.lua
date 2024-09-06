vim.api.nvim_create_user_command('Gco',
    function(opts)
        local args = table.concat(opts.fargs, " ")
        vim.cmd("G checkout " .. args)
    end,
    { nargs = '*' })

vim.api.nvim_create_user_command('Gcb',
    function(opts)
        local args = table.concat(opts.fargs, " ")
        vim.cmd("G checkout -b " .. args)
    end,
    { nargs = '*' })

vim.api.nvim_create_user_command('Gl',
    function(opts)
        local args = table.concat(opts.fargs, " ")
        vim.cmd("G pull " .. args)
    end,
    { nargs = '*' })

vim.api.nvim_create_user_command('Gp',
    function(opts)
        local args = table.concat(opts.fargs, " ")
        vim.cmd("G push " .. args)
    end,
    { nargs = '*' })

vim.api.nvim_create_user_command('Gpf',
    function(opts)
        local args = table.concat(opts.fargs, " ")
        vim.cmd("G --force-with-lease " .. args)
    end,
    { nargs = '*' })

vim.api.nvim_create_user_command('Gpsup',
    function(opts)
        local args = table.concat(opts.fargs, " ")
        local branch_name = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
        vim.cmd("G push -u origin " .. branch_name .. "" .. args)
    end,
    { nargs = '*' })

vim.api.nvim_create_user_command('Gf',
    function(opts)
        local args = table.concat(opts.fargs, " ")
        vim.cmd("G fetch" .. args)
    end,
    { nargs = '*' })

vim.api.nvim_create_user_command('Glog',
    function(opts)
        local args = table.concat(opts.fargs, " ")
        vim.cmd("G log" .. args)
    end,
    { nargs = '*' })

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gco", function()
    local user_input = vim.fn.input("Checkout: ")
    if user_input ~= "" then
        vim.cmd("Gco " .. user_input)
    end
    end)
vim.keymap.set("n", "<leader>gcb", function()
    local user_input = vim.fn.input("New Branch: ")
    if user_input ~= "" then
        vim.cmd("Gcb " .. user_input)
    end
    end)
vim.keymap.set("n", "<leader>gf", function()
    vim.cmd("Gf")
    end)
vim.keymap.set("n", "<leader>glog", function()
    vim.cmd("Glog")
    end)
vim.keymap.set("n", "<leader>gbl", function()
    vim.cmd("G blame")
    end)
vim.keymap.set("n", "<leader>ga", function()
    vim.cmd("G add % --patch")
    end)
vim.keymap.set("n", "<leader>gap", function()
    vim.cmd("G add --all --patch")
    end)
