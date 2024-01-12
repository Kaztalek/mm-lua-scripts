-- "wind.lua"
-- gives amount of frames between wind cycles and duration of wind

wind_power_addr = 0x3fdbd8
visual_frame_addr = 0x1f9f80
original_wind_frame = mainmemory.read_u32_be(visual_frame_addr)
original_calm_frame = original_wind_frame
default_wind_power = 30
wind_blowing = mainmemory.readfloat(wind_power_addr, true) > default_wind_power
wind_duration = 0
calm_duration = 0

while true do
    visual_frame = mainmemory.read_u32_be(visual_frame_addr)

    if mainmemory.readfloat(wind_power_addr, true) <= default_wind_power then
        if wind_blowing then
            original_calm_frame = visual_frame
            calm_duration = 0
        end
        calm_duration = visual_frame - original_calm_frame
    else
        if not(wind_blowing) then
            original_wind_frame = visual_frame
            wind_duration = 0
        end
        wind_duration = visual_frame - original_wind_frame
    end

    wind_blowing = mainmemory.readfloat(wind_power_addr, true) > default_wind_power

    local x = 300
    local y = 100
    local offset = 20
    gui.text(x, y, 'frames since last wind: ' .. calm_duration)
    gui.text(x, y + offset, 'last wind duration: ' .. wind_duration)

    emu.frameadvance()
end
