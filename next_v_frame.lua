-- "next_v_frame.lua"
-- press specified key to get to next visual frame
key = "RightBracket"

dofile("lib/get_version.lua")

local addr_visual_frame = 0x1f9f80
if version == "J1.1" then
    addr_visual_frame = 0x1fa3a0
end

toggle_frame_advance = false

while true do
    local visual_frame = mainmemory.read_u32_be(addr_visual_frame)
    if input.get()[key] then
        if not toggle_frame_advance then
            toggle_frame_advance = true
            client.unpause()
            while mainmemory.read_u32_be(addr_visual_frame) == visual_frame do
                emu.frameadvance()
            end
            client.pause()
        end
    else
        toggle_frame_advance = false
    end
    emu.yield()
end
