-- "low_a_la_skip.lua"
-- goal is to simply zora hover while pause buffering
-- j1.1
dofile("lib/visual_frame_helpers.lua")

local addr_weapon_in_hand = 0x4003a7
local addr_frame_rate_divisor = 0x1cbec3

local last_frame_rate_divisor
local gameplay_frame = 0
local animation_length = 8
local is_weapon_drawn = true

event.onexit(function ()
    gui.clearGraphics()
end)

-- restarts zora hover cycle on load state
-- (so only save state when animation_frame is 0)
event.onloadstate(function ()
    gameplay_frame = 0
end)

function process_zora_hover()
    local cadence = animation_length
    local inputs = joypad.get()
    if inputs["P1 X Axis"] ~= 0 or inputs["P1 Y Axis"] ~= 0 then
        cadence = animation_length + 1
    end

    if memory.read_u8(addr_weapon_in_hand) == 0 then
        is_weapon_drawn = false
    end
    if not is_weapon_drawn then
        cadence = cadence + 2
    end

    local animation_frame = gameplay_frame % cadence
    if animation_frame == 0 then
        is_weapon_drawn = true
        gameplay_frame = 0
        joypad.set({B=1}, 1)
    end
    gameplay_frame = gameplay_frame + 1

    local x = 300
    local y = 100
    gui.drawString(x, y, "animation_frame: " .. animation_frame)
    gui.drawString(x, y + 14, "cadence: " .. cadence .. " frames")
end

while true do
    local frame_rate_divisor = memory.read_u8(addr_frame_rate_divisor)
    local visual_frame = get_visual_frame()
    if frame_rate_divisor == 2 and visual_frame % 2 == 0 then
        joypad.set({Start=1}, 1)
    elseif frame_rate_divisor == 3 and last_frame_rate_divisor == 2 then
        process_zora_hover()
        advance_visual_frame()
        joypad.set({Start=1}, 1)
    end
    last_frame_rate_divisor = frame_rate_divisor

    emu.yield()
end
