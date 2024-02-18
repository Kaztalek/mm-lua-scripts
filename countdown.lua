-- "countdown.lua"
-- script to countdown 72 hours, with gametime counting in real time
local start_time = 1708282800

local addr_gametime = 0x1ef67c
local addr_rate_of_time = 0x1ef684
local addr_day = 0x1ef688
local addr_a_visibility = 0x3fd76f

local client_width = client.screenwidth()
local char_width = 10

mainmemory.write_s32_be(addr_rate_of_time, -3)

function center_text(text, y)
    local x = client_width / 2 - char_width * #text / 2
    gui.text(x, y, text)
end

while true do
    local seconds_since_start = os.time() - start_time
    mainmemory.write_u16_be(addr_gametime, math.floor(seconds_since_start * 512 / 675 + 16384) % 65536)

    mainmemory.write_u8(addr_a_visibility, 0)

    local seconds_remaining = 72 * 60 * 60 - seconds_since_start
    local countdown_s = seconds_remaining % 60
    local countdown_m = math.floor(seconds_remaining / 60) % 60
    local countdown_h = math.floor(seconds_remaining / 60 / 60)

    center_text("-" .. countdown_h .. ":" .. bizstring.pad_start(countdown_m, 2, "0") .. ":" .. bizstring.pad_start(countdown_s, 2, "0"), 890)
    emu.frameadvance()
end
