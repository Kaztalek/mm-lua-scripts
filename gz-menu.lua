-- "gz-menu.lua"

local hold_duration = 3 -- how long to hold button while inputting
local wait = 3 -- how long to wait between the same inputs

-- "P1 A Down": "False"
-- "P1 A Left": "False"
-- "P1 A Right": "False"
-- "P1 A Up": "False"
-- "P1 A": "False"
-- "P1 B": "False"
-- "P1 C Down": "False"
-- "P1 C Left": "False"
-- "P1 C Right": "False"
-- "P1 C Up": "False"
-- "P1 DPad D": "False"
-- "P1 DPad L": "False"
-- "P1 DPad R": "False"
-- "P1 DPad U": "False"
-- "P1 L": "False"
-- "P1 R": "False"
-- "P1 Start": "False"
-- "P1 Z": "False"
-- "Power": "False"
-- "Reset": "False"


function input(instruction)
    if type(instruction) == "number" then
        for i = 1, instruction do
            emu.frameadvance()
        end
        return
    end
    local pressed = {}
    for k, v in pairs(instruction) do
        pressed[v] = true
    end
    for i = 1, hold_duration do
        joypad.set(pressed, 1)
        emu.frameadvance()
    end
end

function input_set(inputs)
    for i = 1, #inputs do
        input(inputs[i])
    end
end

function delay(start_frame)
    while true do
        if emu.framecount() >= start_frame then
            return
        end
        emu.frameadvance()
    end
end

function play_adlowc()
    delay(447)
    input_set({
        {"R", "L"}, -- open menu
        {"DPad U"},
        {"L"}, -- enter settings
        {"DPad D"},
        {"L"}, -- enter commands
        {"DPad R"},
        wait,
        {"DPad R"},
        {"L"}, -- next page
        {"DPad R"},
        {"DPad D"},
        wait,
        {"DPad D"},
        wait,
        {"DPad D"},
        wait,
        {"DPad D"},
        wait,
        {"DPad D"},
        wait,
        {"DPad D", "L"}, -- bind play macro
        wait,
        {"R"}, -- set play macro to R
        wait,
        {"R", "DPad L"}, -- back to settings menu
        {"DPad R"},
        {"DPad U"},
        wait,
        {"DPad U", "L"}, -- turn off pause display
        {"DPad R"},
        {"DPad U"},
        wait,
        {"DPad U"},
        wait,
        {"DPad U"},
        {"DPad L", "L"}, -- turn off input display
        wait,
        {"R", "L"}, -- hide menu
        69, -- wait (prevent sound bug)
        {"R"} -- play macro on frame 630
    })
end

function play_shadow()
    delay(434)
    input_set({
        {"DPad D"}, -- pause game
        {"R", "L"}, -- open menu
        {"DPad D"},
        wait,
        {"DPad D"},
        {"L"}, -- enter scene
        {"DPad D"},
        {"L"}, -- enter collision
        {"DPad R"},
        {"L"}, -- show collision
        {"DPad D"},
        wait,
        {"DPad D"},
        wait,
        {"DPad D"},
        wait,
        {"DPad D", "L"}, -- turn on polygon class
        {"R", "DPad L"}, -- back to scene
        {"DPad D"},
        wait,
        {"DPad D", "L"}, -- enter free camera
        {"DPad R"},
        {"L"}, -- enable free camera
        {"DPad D"},
        wait,
        {"DPad D", "L"}, -- select mode
        {"DPad U"},
        {"L"}, -- set mode to view
        {"DPad D"},
        {"L"}, -- select behavior
        {"DPad D"},
        {"L"}, -- select radial follow
        {"R", "DPad L"}, -- back to scene
        wait,
        {"R", "DPad L"}, -- back to main menu
        {"DPad U"},
        wait,
        {"DPad U"},
        wait,
        {"DPad U", "L"}, -- enter settings
        {"DPad D"},
        {"DPad R"},
        wait,
        {"DPad R"},
        {"DPad D", "L"}, -- turn off pause display
        {"DPad R"},
        {"DPad U"},
        wait,
        {"DPad U"},
        wait,
        {"DPad U"},
        {"DPad L", "L"}, -- turn off input display
        wait,
        {"R", "DPad L"}, -- back to main menu
        {"DPad U"},
        wait,
        {"DPad U"},
        wait,
        {"DPad U", "L"}, -- enter macro
        wait,
        {"DPad U"},
        {"DPad R", "L"}, -- play movie
        62,
        {"R", "L"}, -- hide menu
        {"DPad D"}, -- unpause
    })
end

play_adlowc()
-- play_shadow()
