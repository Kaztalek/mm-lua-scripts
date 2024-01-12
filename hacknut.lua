-- "hacknut.lua"
-- hacks a nut at a specific frame for 3daytest2.bk2
-- lol
-- also hacks bombchu count in 3daytest3.bk2 cuz idc
-- also hacks 15 snowhead fairies in 3daytest3.bk2

local nut_addr = 0x1ef6e9
local nut_ammo_addr = 0x1ef719
local chu_ammo_addr = 0x1ef717
local sh_fairy_addr = 0x1ef745
local nut_frame = 107830
local chu_frame = 246970
local sh_fairy_frame = 281930

console.clear()

while true do
    if emu.framecount() == nut_frame then
        mainmemory.writebyte(nut_addr, 9)
        mainmemory.writebyte(nut_ammo_addr, 1)
        console.log('ok')
    elseif emu.framecount() == chu_frame then
        mainmemory.writebyte(chu_ammo_addr, 19)
        console.log('ok')
    elseif emu.framecount() == sh_fairy_frame then
        mainmemory.writebyte(sh_fairy_addr, 15)
        console.log('ok')
    end
    emu.frameadvance()
end
