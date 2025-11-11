-- "export_pictograph.lua"
-- exports pictograph to raw bytes file

local filename = "picto_" .. os.date("%Y%m%d_%H%M%S") .. ".bin"

local addr_current_pictograph = 0x1F0750

local pictograph_array = mainmemory.read_bytes_as_array(addr_current_pictograph, 11200)

local pictograph_bytes = string.char(table.unpack(pictograph_array))

local file = assert(io.open("pictographs/" .. filename, "wb"))
file:write(pictograph_bytes)
file:close()
