local IsaacHelper = {}
IsaacHelper._VERSION = '1.0.0'
IsaacHelper._VERSION_NUM = 1

local submodules = {}

-- Enumerator for the different submodules 
IsaacHelper.Submodules = {
    EXTRA_MATH = "ExtraMath"
}

-- The below loads all modules and caches them.
-- This will load them again if this is called for a second time.
-- It should work with luamod.
function IsaacHelper:Init(ModReference, ModFileName)
    local path = ModFileName .. ".Modules"
    local modPath = "%s.%s"

    for _, name in pairs(IsaacHelper.Submodules) do
        local submodule = include(modPath:format(path, name))
        if type(submodule) == "table" then -- if it doesnt exist, just move on
            local initSuccess = submodule(ModReference, ModFileName)
            if initSuccess ~= true then
                print("Failed to initialize submodule: " .. initSuccess) -- it'll return an error message
            else
                submodules[name] = submodule
            end
        end
    end
end

function IsaacHelper:GetModule(SubmoduleName)
    return submodules[SubmoduleName]
end

function IsaacHelper:GetVersion(SubmoduleName)
    local submodule = submodules[SubmoduleName]
    if submodule ~= nil then
        return submodule._VERSION
    end
    return IsaacHelper._VERSION
end

function IsaacHelper:GetVersionNum(SubmoduleName)
    local submodule = submodules[SubmoduleName]
    if submodule ~= nil then
        return submodule._VERSION_NUM
    end
    return IsaacHelper._VERSION_NUM
end

-- Define alias
IsaacHelper.Get = IsaacHelper.GetModule

return IsaacHelper