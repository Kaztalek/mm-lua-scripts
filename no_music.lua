--"no_music.lua"
--For use in MM (U) on BizHawk 1.9.1
--Addresses:
--0x2050D5 is BGM

while true do
    mainmemory.writebyte(0x2050D5, 0xEF)
    emu.frameadvance()
end
