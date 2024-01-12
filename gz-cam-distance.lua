-- by glank
-- oot addresses, these are for oot-1.0
local file_addr = 0x0011a5d0
local player_addr = 0x001daa30
local link_age_offset = 0x004
local actor_pos_offset = 0x0024

-- address of the `struct gz`, you can find this for your gz-oot-1.0 build with
--     mips64-nm bin/gz/oot-1.0/gz.elf | grep gz
-- should be the first result, remember to drop the leading 8 as bizhawk works
-- with physical addresses
local gz_addr = 0x00503f10
local cam_pos_offset = 0x0218

function get_target_point()
    local player_pos_addr = player_addr + actor_pos_offset
    local x = mainmemory.readfloat(player_pos_addr + 0x0000, true)
    local y = mainmemory.readfloat(player_pos_addr + 0x0004, true)
    local z = mainmemory.readfloat(player_pos_addr + 0x0008, true)

    local link_age_addr = file_addr + link_age_offset
    local link_age = mainmemory.read_s32_be(link_age_addr)

    if link_age == 0 then
        y = y + 55
    else
        y = y + 35
    end

    return { x = x, y = y, z = z }
end

function get_camera_pos()
    local cam_pos_addr = gz_addr + cam_pos_offset
    local x = mainmemory.readfloat(cam_pos_addr + 0x0000, true)
    local y = mainmemory.readfloat(cam_pos_addr + 0x0004, true)
    local z = mainmemory.readfloat(cam_pos_addr + 0x0008, true)

    return { x = x, y = y, z = z }
end

function frame_end_fn()
    local target_pos = get_target_point()
    local camera_pos = get_camera_pos()

    local dx = target_pos.x - camera_pos.x
    local dy = target_pos.y - camera_pos.y
    local dz = target_pos.z - camera_pos.z

    local d = math.sqrt(dx * dx + dy * dy + dz * dz)

    gui.text(0, 14 * 3, string.format("%.2f", d))
end

event.onframeend(frame_end_fn)
