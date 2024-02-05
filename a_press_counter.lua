-- "a_press_counter.lua"
-- requires movie file. counts A presses and held state
-- shouldn't be used on its own. import from another file and use the global variables as you wish

a_press_count = 0
last_a_held_state = false

-- determines if A is held on given frame
-- increments global A press count by 1 if there's a new press
-- updates global A held state
function update_a_count_on_frame(frame)
    if not movie.isloaded or frame >= movie.length() then
        return
    end
    local a_held_state = movie.getinput(frame)["P1 A"]
    if not last_a_held_state and a_held_state then
        a_press_count = a_press_count + 1
    end
    last_a_held_state = a_held_state
end

-- updates global A press count for the entire movie up to the current frame
function update_total_a_press_count()
    a_press_count = 0
    for i = 0, emu.framecount(), 1 do
        update_a_count_on_frame(i)
    end
end

-- count all A presses on load state
event.onloadstate(function ()
    update_total_a_press_count()
end)

-- count all A presses on script start
update_total_a_press_count()

event.onframeend(function()
    -- update A press count per frame
    update_a_count_on_frame(emu.framecount())
end)
