local IsaacHelper = {}
IsaacHelper._VERSION = '2.0.0'
IsaacHelper._VERSION_NUM = 2
IsaacHelper.Enum = {}

local submodules = {}

-- Enumerator for the different submodules 
IsaacHelper.Enum.Submodules = {
    EXTRA_MATH = "ExtraMath",
    PLAYER_TRACKER = "PlayerTracker",
}

-- The below loads all modules and caches them.
-- This will load them again if this is called for a second time.
-- It should work with luamod.
function IsaacHelper.Init(ModReference, ModFileName)
    local path = ModFileName .. ".Modules"
    local modPath = "%s.%s"

    for _, name in pairs(IsaacHelper.Enum.Submodules) do
        local submodule = include(modPath:format(path, name))
        if type(submodule) == "table" then -- if it doesnt exist, just move on
            local initSuccess = submodule.Init(ModReference, ModFileName)
            if initSuccess ~= true then
                print("Failed to initialize submodule: " .. initSuccess) -- it'll return an error message
            else
                submodules[name] = submodule
            end
        end
    end
end

function IsaacHelper.GetModule(SubmoduleName)
    return submodules[SubmoduleName]
end

return IsaacHelper