memory.usememorydomain("RDRAM")

dofile("lib/get_version.lua")

addr_visual_frame = 0x1f9f80
if version == "J1.1" then
    addr_visual_frame = 0x1fa3a0
end

function get_visual_frame()
    return memory.read_u32_be(addr_visual_frame)
end

function advance_visual_frame()
    local visual_frame = get_visual_frame()
    while memory.read_u32_be(addr_visual_frame) == visual_frame do
        emu.frameadvance()
    end
end
