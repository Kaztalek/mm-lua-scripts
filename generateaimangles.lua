-- "generateaimangles.lua"
--
-- start with C-Up Vertical at 0
-- writes how much angle changes per frame given control stick y coordinate

local offset = 62 -- start at a specific angle

local addr_cup_vertical = 0x3ffdf8
local addr_visual_frame = 0x1f9f80

local file = io.open("angle_log.txt", "a")
local original_frame = mainmemory.read_u32_be(addr_visual_frame)
local curr_frame = 0
local last_frame = 0
local angle = 0
local last_angle = 0

while curr_frame < 128 do
    joypad.setanalog({["X Axis"]=0, ["Y Axis"]=-curr_frame}, 1)

    curr_frame = mainmemory.read_u32_be(addr_visual_frame) - original_frame + offset

    if curr_frame ~= last_frame then
        angle = mainmemory.read_s16_be(addr_cup_vertical)
        value = angle - last_angle
        last_frame = curr_frame
        last_angle = angle

        console.log(curr_frame .. ": " .. value)
        file:write(value .. "\n")
        file:flush()
    end

    emu.frameadvance()
end
