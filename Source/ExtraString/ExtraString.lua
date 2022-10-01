local ExtraString = {}
ExtraString._VERSION = '1.0.0'
ExtraString._VERSION_NUM = 1
ExtraString.Enum = {}

function ExtraString.ToBoolean(s)
    if s == "true" then
        return true
    elseif s == "false" then
        return false
    end
    
    return nil
end

function ExtraString.Split(str, separator)
    local result = {}

    local output = {}
    for s in string.gmatch(str, "([^" .. separator .. "]+)") do
        output[#output + 1] = s
    end

    return result
end

function ExtraString.EndsWith(str, phrase)
    return string.sub(str, (str:len() - phrase:len()) + 1) == phrase
end

function ExtraString.StartsWith(str, phrase)
    return string.sub(str, 1, phrase:len()) == phrase
end

function ExtraString.Init(ModReference, ModFileName)
    return true
end

return ExtraString