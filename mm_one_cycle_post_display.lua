-- "mm_one_cycle_post_display.lua"
-- OSD for clips to edit in post for the One Cycle LOTAD
-- optimized for my display (1280x960 with cropped borders)

local addr_c_left_visibility = 0x3fd773
local addr_rupee_visibility = 0x3fd77b

local display_frame_A = 78834

local display_frame_B = 206051

while true do
    local framecount = emu.framecount()
    -- one time script, don't care, etc
    if framecount == display_frame_A then
        mainmemory.write_u8(addr_rupee_visibility, 0x1f)
    elseif framecount == display_frame_A + 6 then
        mainmemory.write_u8(addr_rupee_visibility, 0x5f)
    elseif framecount == display_frame_A + 9 then
        mainmemory.write_u8(addr_rupee_visibility, 0x9f)
    elseif framecount == display_frame_A + 12 then
        mainmemory.write_u8(addr_rupee_visibility, 0xdf)
    elseif framecount == display_frame_A + 15 then
        mainmemory.write_u8(addr_rupee_visibility, 0xff)
    end

    if framecount == display_frame_B then
        mainmemory.write_u8(addr_rupee_visibility, 0x1f)
        mainmemory.write_u8(addr_c_left_visibility, 0x1f)
    elseif framecount == display_frame_B + 6 then
        mainmemory.write_u8(addr_rupee_visibility, 0x5f)
        mainmemory.write_u8(addr_c_left_visibility, 0x5f)
    elseif framecount == display_frame_B + 9 then
        mainmemory.write_u8(addr_rupee_visibility, 0x9f)
        mainmemory.write_u8(addr_c_left_visibility, 0x9f)
    elseif framecount == display_frame_B + 12 then
        mainmemory.write_u8(addr_rupee_visibility, 0xdf)
        mainmemory.write_u8(addr_c_left_visibility, 0xdf)
    elseif framecount == display_frame_B + 15 then
        mainmemory.write_u8(addr_rupee_visibility, 0xff)
        mainmemory.write_u8(addr_c_left_visibility, 0xff)
    end
    emu.frameadvance()
end
