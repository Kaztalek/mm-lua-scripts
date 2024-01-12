-- "zorahover.lua"
-- old script

local addr_visual_frame = 0x1f9f80
if version == "J1.1" then
    addr_visual_frame = 0x1fa3a0
end
original_frame = mainmemory.read_u32_be(addr_visual_frame)

while true do
    curr_frame = mainmemory.read_u32_be(addr_visual_frame) - original_frame
    if curr_frame % 10 == 0 then
        joypad.set({B=1}, 1)
    end

    local x = 300
    local y = 100
    gui.text(x, y, 'curr_frame: ' .. curr_frame)
    emu.frameadvance()
end
