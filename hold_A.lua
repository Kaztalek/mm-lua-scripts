-- "hold_A.lua"
-- simply holds A for you, for Low A purposes

while true do
    joypad.set({A=1}, 1)
    emu.frameadvance()
end
