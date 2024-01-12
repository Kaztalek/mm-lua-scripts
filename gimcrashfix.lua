-- "gimcrashfix.lua"
-- prevent Bizhawk from crashing on LA gim

local get_item_addr = 0x400134
local poke_addr = 0x779706

while true do
    if mainmemory.read_s16_be(get_item_addr) == -63 then
        mainmemory.writebyte(poke_addr, 0)
        -- console.log('done')
        -- break
    end
    emu.frameadvance()
end
