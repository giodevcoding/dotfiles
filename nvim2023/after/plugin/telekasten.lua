local telekasten = require("telekasten")

local home = vim.fn.expand("~/zk")

telekasten.setup({
    home = home,
    dailies = home .. "/journal/daily",
    weeklies = home .. "/journal/weekly",

    template_new_note = home .. '/templates/new_note.md',
    template_new_daily = home .. '/templates/daily.md',
    template_new_weekly= home .. '/templates/weekly.md',
})
