local telekasten = require("telekasten")
local is_windows = require("giovanni.functions").is_windows

local home = vim.fn.expand("~/zk")

--Windows
if not (is_windows()) then
    telekasten.setup({
        home = home,
        dailies = home .. "/journal/daily",
        weeklies = home .. "/journal/weekly",

        template_new_note = home .. '/templates/new_note.md',
        template_new_daily = home .. '/templates/daily.md',
        template_new_weekly= home .. '/templates/weekly.md',
    })
end

