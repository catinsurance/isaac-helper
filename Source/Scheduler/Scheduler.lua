local Scheduler = {}
Scheduler._VERSION = '1.0.0'
Scheduler._VERSION_NUM = 1
Scheduler.Enum = {
    ONE_SECOND = 30,
}

local scheduled = {}
local game = Game()
local function Update()
    for index, task in ipairs(scheduled) do
        if task.When <= game:GetFrameCount() then
            task.Callback(table.unpack(task.Arguments)) -- unpack those arguments and pass them into the callback
            table.remove(scheduled, index)
        end
    end
end

function Scheduler.Schedule(frameDelay, callback, ...)
    table.insert(scheduled,
        {
            When = game:GetFrameCount() + frameDelay,
            Callback = callback,
            Arguments = table.pack(...) -- pack those arguments into a table
        }
    )
end

function Scheduler.Init(YourMod)
    Scheduler.Empty() -- clear the scheduled tasks
    YourMod:AddCallback(ModCallbacks.MC_POST_UPDATE, Update)
    YourMod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, Scheduler.Empty)
    YourMod:AddCallback(ModCallbacks.MC_POST_GAME_END, Scheduler.Empty)
    return true
end

function Scheduler.Empty()
    scheduled = {}
end

return Scheduler