-- "3dayinfo.lua"
--
-- information to be displayed on screen for the 3day video
-- optimized for 1280x960 (height-wise)

local addr_day = 0x1ef688
local addr_day_night = 0x1ef680
local addr_gametime = 0x1ef67c

local client_width = client.screenwidth()
local char_height = 14
local char_width = 10

-- draws text centered horizontally at given height
function center_text(text, y)
    local x = client_width / 2 - char_width * #text / 2
    gui.text(x, y, text)
end

function get_day_text()
    local day = mainmemory.read_u32_be(addr_day)
    local day_night = mainmemory.read_u32_be(addr_day_night)
    local day_text = "Night "
    if (day_night == 0) then
        day_text = "Day "
    end
    return day_text .. day .. ", "
end

function display_time(h, m)
    local pm = "pm"
    if h < 12 then
        pm = "am"
    else
        h = h - 12
    end
    if h == 0 then
        h = 12
    end
    local h_m_separator = ":"
    if m < 10 then
        h_m_separator = ":0"
    end

    local text = get_day_text() .. h .. h_m_separator .. m .. pm
    center_text(text, 904)
end

-- convert decimal time to clock time
function convert_time_unit(time)
    local decimal = time % 1
    return decimal * 100 * 3 / 5
end

function get_time(gametime)
    local realtime = 3 * gametime / 8192
    local hour = math.floor(realtime)
    local converted_minutes = convert_time_unit(realtime)
    local minute = math.floor(converted_minutes)
    -- local second = math.floor(convert_time_unit(converted_minutes))
    display_time(hour, minute)
end

while true do
    local gametime = mainmemory.read_u16_be(addr_gametime)
    get_time(gametime)
    emu.frameadvance()
end
