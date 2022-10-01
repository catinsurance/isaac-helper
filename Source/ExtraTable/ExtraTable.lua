local ExtraTable = {}
ExtraTable._VERSION = '1.0.0'
ExtraTable._VERSION_NUM = 1
ExtraTable.Enum = {}

function ExtraTable.ShallowCopy(original)
    local copy = {}
    for key, value in pairs(original) do
        copy[key] = value
    end
    return copy
end

function ExtraTable.DeepCopy(original)
    local copy = {}
    for key, value in pairs(original) do
        if type(value) == "table" then
            copy[key] = ExtraTable.DeepCopy(value)
        end
        copy[key] = value
    end
    return copy
end

function ExtraTable.HasValue(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

function ExtraTable.HasKey(table, key)
    for k, _ in pairs(table) do
        if k == key then
            return true
        end
    end
    return false
end

function ExtraTable.Init()
    return true
end

return ExtraTable