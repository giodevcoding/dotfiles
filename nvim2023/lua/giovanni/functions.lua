local function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            return true
        end
    end
    return ok, err
end

local function is_windows ()
    return exists("C:\\Windows");
end

local function is_mac ()
    return exists("/System/Library/");
end

return {
    exists = exists,
    is_windows = is_windows,
    is_mac = is_mac
}
