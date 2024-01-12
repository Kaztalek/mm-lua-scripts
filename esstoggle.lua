-- "esstoggle.lua"
-- press c to toggle between ess positions, starting with left

dir = 1
can_switch = true

while true do
    if input.get().C then
        if can_switch then
            can_switch = false
            dir = -dir
            joypad.setanalog({["X Axis"]=dir*15, ["Y Axis"]=-15}, 1)
        end
    else
        can_switch = true
    end
    local x = 300
    local y = 100
    gui.text(x, y, 'dir: ' .. dir)
    emu.frameadvance()
end
