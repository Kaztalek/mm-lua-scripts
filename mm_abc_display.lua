-- "mm_abc_display.lua"
-- OSD for the A Button Challenge LOTAD
-- depends on "a_press_counter.lua"
-- optimized for my display (1280x960 with cropped borders)
dofile("a_press_counter.lua")

event.onexit(function ()
    gui.clearGraphics()
end)

while movie.isloaded() do
    local rect_x_base = 1020
    local rect_x = rect_x_base
    local rect_y = 902
    if a_press_count < 10 then
        rect_x = rect_x_base + 22
    end

    local text_x = rect_x + 4
    local text_y = 900
    local font_size = 32
    local font_family = "RocknRoll One"
    local value_color = 0xffffffff

    if last_a_held_state then
        value_color = 0xff64c8ff
    end

    gui.drawRectangle(rect_x, rect_y, 1280 - rect_x, 960 - rect_y, 0xff000000, 0xff000000)
    gui.drawText(text_x, text_y, a_press_count, value_color, 0xff000000, font_size, font_family)
    gui.drawText(rect_x_base + 58, text_y, "A presses", 0xffffffff, 0xff000000, font_size, font_family)
    emu.frameadvance()
end
