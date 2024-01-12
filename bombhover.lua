-- "bombhover.lua"
-- toggle on frame you pull out a bomb
-- pauses emu on frame you should input hover
-- pauses emu on frame you should pull next bomb
-- "C" turns off script

-- overwrite with how many frames left on the explosion you want the hover
-- 5 for most height, 10 (or higher) for optimal distance
bomb_frame = 11
visual_frame_addr = 0x1F9F80
original_frame = mainmemory.read_u32_be(visual_frame_addr)
curr_frame = 0
hover_frame = 71 - bomb_frame
shield_frame = 77
end_frame = 79
statuses = {'pull bomb', 'wait to hover', 'hover', 'wait to let go of shield', 'let go of shield', 'wait to pull bomb'}
status = 1
can_pause = true
pause_frame = 0

while input.get().C ~= true do
    curr_frame = mainmemory.read_u32_be(visual_frame_addr) - original_frame
    frame = curr_frame % end_frame

    if frame == 0 then
        status = 1
        if can_pause then
            pause_frame = emu.framecount()
            can_pause = false
        end
    elseif frame < hover_frame then
        can_pause = true
        status = 2
    elseif frame == hover_frame then
        status = 3
        if can_pause then
            pause_frame = emu.framecount()
            can_pause = false
        end
    elseif frame < shield_frame then
        can_pause = true
        status = 4
    elseif frame == shield_frame then
        status = 5
        if can_pause then
            pause_frame = emu.framecount()
            can_pause = false
        end
    else
        can_pause = true
        status = 6
    end

    if pause_frame == emu.framecount() then
        client.pause()
    end

    local x = 300
    local y = 100
    local offset = 20
    gui.text(x, y, 'curr_frame: ' .. curr_frame)
    gui.text(x, y + offset, 'status: ' .. statuses[status])

    emu.frameadvance()
end
