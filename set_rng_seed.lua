-- "set_rng_seed.lua"
-- I got help from glank on doing this, so I want to save it
-- this will execute once on scene load. set the rng value you want during that
-- most likely useful for resolving desyncs
-- MM (U) for now

local rng_seed = 0xd1fcf9c0

local addr_end_of_srand = 0x8016A8A0
local addr_rng_seed = 0x97530

local memory_execute_event = event.onmemoryexecute(function()
    mainmemory.write_u32_be(addr_rng_seed, rng_seed)
end, addr_end_of_srand)

event.onexit(function ()
    event.unregisterbyid(memory_execute_event)
end)
