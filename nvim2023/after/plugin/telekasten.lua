local telekasten = require("telekasten")

local home = vim.fn.expand("~/zk")

local function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            return true
        end
    end
    return ok, err
end


--Windows
if not (exists("C:\\Windows")) then
    telekasten.setup({
        home = home,
        dailies = home .. "/journal/daily",
        weeklies = home .. "/journal/weekly",

        template_new_note = home .. '/templates/new_note.md',
        template_new_daily = home .. '/templates/daily.md',
        template_new_weekly= home .. '/templates/weekly.md',
    })
end

