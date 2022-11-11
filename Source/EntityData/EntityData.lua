local EntityData = {}
EntityData._VERSION = '1.0.0'
EntityData._VERSION_NUM = 1
EntityData.Enum = {}

local data = {}

local function GetPlayerIndex(player) -- if you need this function, you should probably use PlayerTracker instead
    local collectible = 1

    local playerType = player:GetPlayerType()
    if playerType == PlayerType.PLAYER_LAZARUS2_B then
        collectible = 2
    end

    local seed = player:GetCollectibleRNG(collectible):GetSeed()
    return tostring(seed)
end

function EntityData.GetData(entity)
    local index
    if entity.Type == EntityType.ENTITY_PLAYER then
        index = GetPlayerIndex(entity:ToPlayer())
    elseif entity.Type == EntityType.ENTITY_FAMILIAR then
        index = entity.InitSeed
    else
        index = GetPtrHash(entity)
    end

    if not data[index] then
        data[index] = {}
    end

    return data[index]
end

-- removes data associated with a non-existant entity
function EntityData.Clean()
    for index in pairs(data) do
        local exists = false
        for _, entity in ipairs(Game():GetRoom():GetEntities()) do
            if entity.Type == EntityType.ENTITY_PLAYER then
                if GetPlayerIndex(entity:ToPlayer()) == index and entity:Exists() then
                    exists = true
                    break
                end
            elseif entity.Type == EntityType.ENTITY_FAMILIAR and entity:Exists() then
                if entity.InitSeed == index then
                    exists = true
                    break
                end
            else
                if GetPtrHash(entity) == index and entity:Exists() then
                    exists = true
                    break
                end
            end
        end

        if not exists then
            data[index] = nil
        end
    end
end

function EntityData.RemoveData(entity)
    local index
    if entity.Type == EntityType.ENTITY_PLAYER then
        index = GetPlayerIndex(entity:ToPlayer())
    elseif entity.Type == EntityType.ENTITY_FAMILIAR then
        index = entity.InitSeed
    else
        index = GetPtrHash(entity)
    end

    data[index] = nil
end

function EntityData.Init()
    return true
end

return EntityData