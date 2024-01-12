--"levitate.lua"

dofile("lib/get_version.lua")

local addr_y_vel = 0x3ffe18 -- U
if version == "J1.0" then
    addr_y_vel = 0x400008
elseif version == "J1.1" then
    addr_y_vel = 0x4002c8
end

while true do
    if input.get().C then
        mainmemory.writefloat(addr_y_vel, 7.5, true)
    end
    emu.yield()
end
