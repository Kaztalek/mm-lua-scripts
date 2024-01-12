-- "soarcursor.lua"

local cursor_addr = 0x3fda90
local locations = {
    'Great Bay Coast',
    'Zora Cape',
    'Snowhead',
    'Mountain Village',
    'Clock Town',
    'Milk Road',
    'Woodfall',
    'Southern Swamp',
    'Ikana Canyon',
    'Stone Tower'
}
local location = locations[1]

while true do
    local cursor = mainmemory.read_s16_be(cursor_addr)
    if cursor < 0 or cursor >= #locations then
        location = cursor
    else
        location = locations[cursor + 1]
    end
    local x = 0
    local y = 932
    gui.text(x, y, 'IndexWarp Location: ' .. location)
    emu.frameadvance()
end
