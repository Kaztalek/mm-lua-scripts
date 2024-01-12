-- "angles.lua"
--
-- type C to increment angle by step

local starting_angle = 26800
local step = 100

local addr_angle = 0x3ffe6e

local curr_angle = starting_angle
local incrementing = false

function increment_angle(angle, amount)
    return (angle + amount) % 65536
end

while true do
    if input.get().C then
        if not incrementing then
            curr_angle = increment_angle(curr_angle, step)
            mainmemory.write_u16_be(addr_angle, curr_angle)
            incrementing = true
        end
    else
        incrementing = false
    end

    emu.frameadvance()
end
