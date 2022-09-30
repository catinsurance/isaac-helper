--- Utility functions for doing math.

local ExtraMath = {}
ExtraMath._VERSION = '1.0.0'

local function init(ModReference, ModFileName)
    -- we dont need to initialize anything, return true to indicate success
    return true
end

function ExtraMath:Clamp(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    end
    return value
end

--- Returns the value provided rounded to the nearest integer.
function ExtraMath:Round(num)
    local ofs = 2^52
    if math.abs(num) > ofs then
      return num
    end
    return num < 0 and num - ofs + ofs or num + ofs - ofs
end

setmetatable(ExtraMath, {
    __call = function(_, ...)
        return init(...) -- wrap the init function so we can call it like a constructor
    end
})

return ExtraMath