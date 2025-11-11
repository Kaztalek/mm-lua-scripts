-- "import_pictograph.lua"
-- imports raw bytes file to current pictograph image

-- change this!
local filename = "pictographs/picto_20251109_175647.bin"

local addr_current_pictograph = 0x1F0750

local file = assert(io.open(filename, "rb"))
local pictograph_str = file:read("*a")
file:close()

local pictograph_array = {pictograph_str:byte(1, #pictograph_str)}

mainmemory.write_bytes_as_array(addr_current_pictograph, pictograph_array)
-- TODO set pictograph count to 1
