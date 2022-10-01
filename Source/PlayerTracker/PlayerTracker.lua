local PlayerTracker = {}
PlayerTracker._VERSION = '1.0.2'
PlayerTracker._VERSION_NUM = 3

local CharactersWithTwin = {
    PlayerType.PLAYER_JACOB,
    PlayerType.PLAYER_ESAU,
    PlayerType.PLAYER_THEFORGOTTEN_B,
    PlayerType.PLAYER_THESOUL_B,
    PlayerType.PLAYER_LAZARUS_B,
    PlayerType.PLAYER_LAZARUS2_B
}

function PlayerTracker.GetPlayerIndex(player)
    local collectible = 1

    local playerType = player:GetPlayerType()
    if playerType == PlayerType.PLAYER_LAZARUS2_B then
        collectible = 2
    end

    local seed = player:GetCollectibleRNG(collectible):GetSeed()
    return tostring(seed)
end

function PlayerTracker.GetPlayers()
    local game = Game()
    local numPlayers = game:GetNumPlayers() - 1
  
    local players = {}
    for i = 0, numPlayers do
        local player = Isaac.GetPlayer(i)
        players[#players + 1] = player
    end
  
    return players
end

function PlayerTracker.IterPlayers()
    local players = Game():GetNumPlayers() - 1
    local i = 0
  
    return function ()
        while i <= players do
            i = i + 1
            return Isaac.GetPlayer(i)
        end
        return nil
    end
end

function PlayerTracker.HasTwin(playerType)
    for _, twinType in pairs(CharactersWithTwin) do
        if playerType == twinType then
            return true
        end
    end
    return false
end

function PlayerTracker.GetPlayersWithCollectible(collectible, ignoreModifiers)
    local modifiers = ignoreModifiers == nil and false or ignoreModifiers
    local players = PlayerTracker.GetPlayers() - 1
    local playersWithCollectible = {}
    for _, player in ipairs(players) do
        if player:HasCollectible(collectible, modifiers) then
            playersWithCollectible[#playersWithCollectible + 1] = player
        end
    end
    return playersWithCollectible
end

function PlayerTracker.IterPlayersWithCollectible(collectible, ignoreModifiers)
    local current = 0
    local numPlayers = Game():GetNumPlayers() - 1
    return function ()
        while current <= numPlayers do
            local player = Isaac.GetPlayer(current)
            current = current + 1
            if player:HasCollectible(collectible, ignoreModifiers) then
                return player
            end
        end
        return nil
    end
end

function PlayerTracker.Init(ModReference, parentDirectory)
    -- we dont need to initialize anything, return true to indicate success
    return true
end

return PlayerTracker