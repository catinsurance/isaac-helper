local ExtraTable = {}
ExtraTable._VERSION = '1.0.1'
ExtraTable._VERSION_NUM = 2
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

function ExtraTable.Pick(array, rng)
    if not rng then
        rng = RNG()
        rng:SetSeed(Game():GetFrameCount(), 35) -- 35 is the recommended shift index, according to the docs
    end
    
    return array[rng:RandomInt(#array) + 1]
end

function ExtraTable.IsArray(table)
    if type(table ~= "table") then
        return false
    end

    if #table > 0 then
        return true
    end

    for _ in pairs(table) do
        return false
    end

    return true
end

function ExtraTable.IsDictionary(table)
    if (type(table) ~= "table") then
        return false
    end

    if #table > 0 then
        return false
    end

    for _ in pairs(table) do
        return true
    end

    return false
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
    return table[key] ~= nil
end

-- Works for dictionaries as well as arrays
function ExtraTable.Length(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

-- Works for dictionaries as well as arrays
function ExtraTable.IsEmpty(table)
    return ExtraTable.Length(table) == 0
end

-- Makes a new dictionary with the keys set to the values of the provided array and the values all equal to true.
function ExtraTable.Set(array)
    local dict = {}
    for _, v in pairs(array) do
        dict[v] = true
    end
    return dict
end

-- Find the index of a value in a table. Returns nil if not found.
function ExtraTable.Find(table, value)
    for k, v in pairs(table) do
        if v == value then
            return k
        end
    end
    return nil
end

function ExtraTable.PrettyPrint(main, depthLimit)
    depthLimit = depthLimit or 3
    local function prettyPrintTable(table, depth)
        if depthLimit > -1 and depth > depthLimit then
            return
        end

        for k, v in pairs(table) do
            if type(v) == "table" then
                print(string.rep(" ", depth) .. tostring(k) .. ":")
                prettyPrintTable(v, depth + 1)
            else
                print(string.rep(" ", depth) .. tostring(k) .. ": " .. (tostring(v) or "userdata"))
            end
        end
    end

    prettyPrintTable(main, 1)
end

function ExtraTable.Init()
    return true
end

return ExtraTable