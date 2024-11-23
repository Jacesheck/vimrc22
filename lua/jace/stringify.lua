--- Stringify anything
--- @param data any
--- @param indent number | nil
function Stringify(data, indent)
    indent = indent or 0
    local ind = string.rep(" ", indent)

    if type(data) == "nil" then
        print("nil")
    elseif type(data) == "number" or type(data) == "string" then
        print(data)
    elseif type(data) == "boolean" then
        print(tostring(data))
    elseif type(data) == "table" then
        if indent == 0 then
            print(ind .. "{")
        end
        ind = ind .. "  "
        for k, v in pairs(data) do
            if type(v) == "number" then
                print(ind .. k .. " : " .. v .. ",")
            elseif type(v) == "string" then
                print(ind .. k .. " : " .. v .. ",")
            elseif type(v) == "string" then
                print(ind .. k .. " : nil,")
            elseif type(v) == "boolean" then
                print(ind .. k .. " : " .. tostring(v) .. ",")
            elseif type(v) == "table" then
                print(ind .. k .. " : {")
                Stringify(v, indent + 2)
            end
        end
        ind = string.sub(ind, 0, string.len(ind) - 2)
        print(ind .. "}")
    else
        print(ind .. type(data))
    end
end
