-- "import_pictograph.lua"
-- imports raw bytes file to current pictograph image

-- change this!
local filename = "pictographs/picto_20251109_175647.bin"

local addr_current_pictograph = 0x1F0750
local addr_quest_items = 0x1EF72C -- bitfield; just the byte that sets pictograph ammo

local file = assert(io.open(filename, "rb"))
local pictograph_str = file:read("*a")
file:close()

local pictograph_array = {pictograph_str:byte(1, #pictograph_str)}

mainmemory.write_bytes_as_array(addr_current_pictograph, pictograph_array)

-- set pictograph ammo to 1
local quest_item_bits = mainmemory.read_u8(addr_quest_items)
mainmemory.write_u8(addr_quest_items, quest_item_bits | 2) -- pictograph ammo is bit 1 of addr_quest_items
