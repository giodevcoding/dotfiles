local function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

local char_to_hex = function(c)
  return string.format("%%%02X", string.byte(c))
end

local function urlencode(str)
  if str == nil then
    return ""
  end
  return (str:gsub("([^A-Za-z0-9%-_%.~])", function(c)
    return string.format("%%%02X", string.byte(c))
  end))
end

return {
    dump = dump,
    char_to_hex = char_to_hex,
    urlencode = urlencode
}
