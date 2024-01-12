-- "cs_slide.lua"
-- j1.1. (for now)
-- shows movement info, useful for determining if you have a good slide
memory.usememorydomain("RDRAM")

local addr_x_pos = 0x400284
local addr_z_pos = 0x40028c
local addr_visual_frame = 0x1fa3a0

local last_x_pos = memory.readfloat(addr_x_pos, true)
local last_z_pos = memory.readfloat(addr_z_pos, true)
local last_visual_frame = 0
local delta_x = 0.0
local delta_z = 0.0

local text_height = 14
local text_x = 200
local text_y = 0
function screen_print(label, value, line_no)
    -- print(label .. ": " .. value)
    gui.text(text_x, text_y + text_height * line_no, label .. ": " .. value)
end

while true do
    local x_pos = memory.readfloat(addr_x_pos, true)
    local z_pos = memory.readfloat(addr_z_pos, true)
    local visual_frame = memory.read_u32_be(addr_visual_frame)
    if visual_frame > last_visual_frame then
        delta_x = x_pos - last_x_pos
        delta_z = z_pos - last_z_pos
    end
    screen_print("X Movement", delta_x, 1)
    screen_print("Z Movement", delta_z, 2)
    last_x_pos = x_pos
    last_z_pos = z_pos
    last_visual_frame = visual_frame
    emu.frameadvance()
end
