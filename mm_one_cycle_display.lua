-- "mm_one_cycle_display.lua"
-- OSD for the One Cycle LOTAD
-- optimized for my display (1280x960 with cropped borders)

event.onexit(function ()
    gui.clearGraphics()
end)

local addr_day = 0x1ef688
local addr_day_night = 0x1ef680
local addr_gametime = 0x1ef67c

-- draws text at given height, horizontally aligned based on day/night
function display_text(text, text_y, day_text)
    local text_x = 540
    if day_text == "Night" then
        text_x = 520
    end
    gui.drawText(text_x, text_y, text, 0xffffffff, 0xff333333, 24, "RocknRoll One")
end

function get_day_text()
    local day_night = mainmemory.read_u32_be(addr_day_night)
    if (day_night == 0) then
        return "Day"
    end
    return "Night"
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
    local day_time_separator = ", "
    if h < 10 then
        day_time_separator = ", 0"
    end
    local h_m_separator = ":"
    if m < 10 then
        h_m_separator = ":0"
    end

    local day = mainmemory.read_u32_be(addr_day)
    local day_text = get_day_text()
    local text = day_text .. " " .. day .. day_time_separator .. h .. h_m_separator .. m .. pm
    display_text(text, 890, day_text)
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
