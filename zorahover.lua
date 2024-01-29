-- "zorahover.lua"
-- simply presses B at a regular cadence for zora hover punches

-- zora hover can be done every 8 frames, but only in a straight line
-- when analog is held, allow movement by increasing to 9 frames
-- when analog is not held, revert back to 8 frame cadence
-- if fins aren't out, add 2 frames
-- TODO update this script if I ever want to do this with other forms + weapons

local addr_visual_frame = 0x1f9f80
if version == "J1.1" then
    addr_visual_frame = 0x1fa3a0
end

local addr_weapon_in_hand = 0x4003a7

local animation_length = 8
local start_frame = mainmemory.read_u32_be(addr_visual_frame)
local is_weapon_drawn = true

while true do
    local cadence = animation_length
    local inputs = joypad.get()
    if inputs["P1 X Axis"] ~= 0 or inputs["P1 Y Axis"] ~= 0 then
        cadence = animation_length + 1
    end

    if mainmemory.read_u8(addr_weapon_in_hand) == 0 then
        is_weapon_drawn = false
    end
    if not is_weapon_drawn then
        cadence = cadence + 2
    end

    local visual_frame = mainmemory.read_u32_be(addr_visual_frame)
    local animation_frame = (visual_frame - start_frame) % cadence
    if animation_frame == 0 or
    -- if load state on an earlier cycle, just start the cycle at 0
    -- (so only save state when animation_frame is 0)
    visual_frame < start_frame then
        is_weapon_drawn = true
        start_frame = visual_frame
        joypad.set({B=1}, 1)
    end

    local x = 300
    local y = 100
    gui.text(x, y, "animation_frame: " .. animation_frame)
    gui.text(x, y + 14, "cadence: " .. cadence .. " frames")
    emu.frameadvance()
end
