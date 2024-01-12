-- "aslide.lua"
-- toggle this on first frame of explosion (expl timer at 9 with explosivetimer.lua)
-- toggle off when done
-- have Z held yourself

-- overwrite with a diff direction if you want
direction = {["X Axis"]=0, ["Y Axis"]=-128}
neutral = {["X Axis"]=0, ["Y Axis"]=0}
visual_frame_addr = 0x1F9F80
original_frame = mainmemory.read_u32_be(visual_frame_addr)
curr_frame = 0
dir_str = 'neutral'

while true do
    curr_frame = mainmemory.read_u32_be(visual_frame_addr) - original_frame
    if curr_frame % 2 == 0 then
        joypad.setanalog(direction, 1)
        dir_str = 'down'
    else
        joypad.setanalog(neutral, 1)
        dir_str = 'neutral'
    end

    local x = 300
    local y = 100
    local offset = 20
    gui.text(x, y, 'curr_frame: ' .. curr_frame)
    gui.text(x, y + offset, 'dir_str: ' .. dir_str)
    emu.frameadvance()
end
