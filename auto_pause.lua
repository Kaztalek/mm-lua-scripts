-- "auto_pause.lua"
-- j1.1 (for now)
-- pauses emu when game time is within 3 units of specified times (for now)
memory.usememorydomain("RDRAM")

local target_times = {0x28be, 0x37fa} -- aliens enter barn - win

local addr_game_time = 0x1ef71c

while true do
    local game_time = memory.read_u16_be(addr_game_time)
    for index, target_time in pairs(target_times) do
        if game_time > target_time - 3 and game_time < target_time + 3 then
            target_times[index] = nil
            client.pause()
        end
    end
    emu.frameadvance()
end
