local IsaacHelper = {}
IsaacHelper._VERSION = '2.1.0'
IsaacHelper._VERSION_NUM = 5
IsaacHelper.Enum = {}

local submodules = {}
local modRef, modName

-- Enumerator for the different submodules 
IsaacHelper.Enum.Submodules = {
    EXTRA_MATH = "ExtraMath",
    PLAYER_TRACKER = "PlayerTracker",
    EXTRA_STRING = "ExtraString",
    EXTRA_TABLE = "ExtraTable",
    SCHEDULER = "Scheduler",
    ENTITY_DATA = "EntityData",
}

local function LoadModule(path, name)
    local modPath = "%s.%s"
    local submodule = include(modPath:format(path, name))
    if type(submodule) == "table" then -- if it doesnt exist, just move on
        local initSuccess = submodule.Init(modRef, modName)
        if initSuccess ~= true then
            Isaac.DebugString("[ISAAC-HELPER] Failed to initialize submodule: " .. initSuccess) -- it'll return an error message
        else
            submodules[name] = submodule
        end
    end
end

-- The below gives isaac-helper the information it needs to load modules.
-- It should work with luamod.
-- Calling it will unload all loaded modules!
function IsaacHelper.Init(ModReference, ModFileName)
    modRef = ModReference
    modName = ModFileName
    submodules = {}
end

function IsaacHelper.GetModule(SubmoduleName)
    if submodules[SubmoduleName] == nil then
        LoadModule(modName .. ".Modules", SubmoduleName)
    end
    
    return submodules[SubmoduleName]
end

return IsaacHelper