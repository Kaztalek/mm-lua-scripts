-- ??????????
-- old script lol
-- deprecated: use pause_buffer.lua
memory.usememorydomain("RDRAM")

local frame = 0x1FA3A0
local a = 0x3FDB8B
local buffer = false

while true do
    local A = memory.readbyte(a)
    if A ~= lastA and lastA == 21 then
        x = emu.framecount() + 20
        buffer = true
    elseif buffer and emu.framecount() > x and memory.read_u32_be(frame) > lastFrame then
        joypad.set({Start=1},1)
        buffer = false
    elseif A == 21 and emu.framecount() % 2 == 0 then
        joypad.set({Start=1},1)
    end
    lastA = memory.readbyte(a)
    lastFrame = memory.read_u32_be(frame)
    emu.frameadvance()
end
