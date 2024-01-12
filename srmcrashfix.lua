-- "srmcrashfix.lua"
-- pokes values to prevent Bizhawk from crashing on human srm
-- delay writing to addresses until after the textbox is closed

local addr1 = 0x4242d0
local addr2 = 0x4242d4
local visual_frame_addr = 0x1F9F80
local done = false
local write_frame = -1;

while done ~= true do
    if write_frame == -1 and mainmemory.read_u32_be(addr2) == 0x27bdff38 then
        write_frame = mainmemory.read_u32_be(visual_frame_addr) + 2
    end
    if mainmemory.read_u32_be(visual_frame_addr) == write_frame then
        mainmemory.write_u32_be(addr2, 0)
        mainmemory.write_u32_be(addr1, 0x03e00008)
        done = true
    end
    -- local x = 300
    -- local y = 0
    -- gui.text(x, y, 'write_frame: ' .. write_frame)
    emu.frameadvance()
end
