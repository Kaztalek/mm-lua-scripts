-- "straighthess.lua"
-- toggle this on first frame you can target on hess (or earlier) (expl timer at 8 with explosivetimer.lua)
-- toggle off when done
-- have Z held yourself

-- overwrite with a diff direction if you want
left = {["X Axis"]=-15, ["Y Axis"]=-15}
right = {["X Axis"]=15, ["Y Axis"]=-15}
visual_frame_addr = 0x1F9F80
original_frame = mainmemory.read_u32_be(visual_frame_addr)
curr_frame = 0
dir_str = 'left'

while true do
    curr_frame = mainmemory.read_u32_be(visual_frame_addr) - original_frame
    if curr_frame % 2 == 0 then
        joypad.setanalog(right, 1)
        dir_str = 'right'
    else
        joypad.setanalog(left, 1)
        dir_str = 'left'
    end

    local x = 300
    local y = 100
    local offset = 20
    gui.text(x, y, 'curr_frame: ' .. curr_frame)
    gui.text(x, y + offset, 'dir_str: ' .. dir_str)
    emu.frameadvance()
end
