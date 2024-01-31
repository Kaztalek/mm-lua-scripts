-- "pause_buffer.lua"
-- j1.1 for now
dofile("lib/visual_frame_helpers.lua")

local addr_frame_rate_divisor = 0x1cbec3

local last_frame_rate_divisor

while true do
    local frame_rate_divisor = memory.read_u8(addr_frame_rate_divisor)
    local visual_frame = memory.read_u32_be(addr_visual_frame)
    if frame_rate_divisor == 2 and visual_frame % 2 == 0 then
        joypad.set({Start=1}, 1)
    elseif frame_rate_divisor == 3 and last_frame_rate_divisor == 2 then
        advance_visual_frame()
        joypad.set({Start=1}, 1)
    end
    last_frame_rate_divisor = frame_rate_divisor
    emu.yield()
end
