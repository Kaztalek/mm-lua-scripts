-- "zorahover.lua"
-- simply presses B at a regular cadence for zora hover punches

-- zora hover can be done every 8 frames, but only in a straight line
-- when analog is held, allow movement by increasing to 9 frames
-- when analog is not held, revert back to 8 frame cadence

local addr_visual_frame = 0x1f9f80
if version == "J1.1" then
    addr_visual_frame = 0x1fa3a0
end

local animation_length = 8
local start_frame = mainmemory.read_u32_be(addr_visual_frame)

while true do
    local cadence = animation_length
    local inputs = joypad.get()
    if inputs["P1 X Axis"] ~= 0 or inputs["P1 Y Axis"] ~= 0 then
        cadence = animation_length + 1
    end

    local visual_frame = mainmemory.read_u32_be(addr_visual_frame)
    local animation_frame = visual_frame - start_frame
    if animation_frame % cadence == 0 then
        start_frame = visual_frame
        joypad.set({B=1}, 1)
    end

    local x = 300
    local y = 100
    gui.text(x, y, "animation_frame: " .. animation_frame)
    gui.text(x, y + 14, "cadence: " .. cadence .. " frames")
    emu.frameadvance()
end
