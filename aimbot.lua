-- "aimbot.lua"
--
-- set x_target and y_target to target position
-- start with aiming device out
-- will naively move control stick until at target location
-- TODO: allow hex instead of just s16

local y_target = -4083
local x_target = -26563

dofile("lib/get_version.lua")

local addr_cup_vertical = 0x3ffdf8
local addr_cup_horizontal = 0x3ffdfa
local addr_visual_frame = 0x1f9f80
if version == "J1.1" then
    addr_cup_vertical = 0x4002a8
    addr_cup_horizontal = 0x4002aa
    addr_visual_frame = 0x1fa3a0
end

local original_frame = mainmemory.read_u32_be(addr_visual_frame)
local curr_frame = 0
local last_frame = 0

local x = 0
local y = 0

local angles = {
    {val=887, pos=70},
    {val=862, pos=69},
    {val=835, pos=68},
    {val=810, pos=67},
    {val=784, pos=66},
    {val=760, pos=65},
    {val=734, pos=64},
    {val=710, pos=63},
    {val=685, pos=62},
    {val=662, pos=61},
    {val=637, pos=60},
    {val=614, pos=59},
    {val=590, pos=58},
    {val=590, pos=57},
    {val=569, pos=56},
    {val=545, pos=55},
    {val=524, pos=54},
    {val=502, pos=53},
    {val=481, pos=52},
    {val=459, pos=51},
    {val=440, pos=50},
    {val=419, pos=49},
    {val=400, pos=48},
    {val=380, pos=47},
    {val=361, pos=46},
    {val=342, pos=45},
    {val=325, pos=44},
    {val=306, pos=43},
    {val=290, pos=42},
    {val=272, pos=41},
    {val=257, pos=40},
    {val=240, pos=39},
    {val=225, pos=38},
    {val=210, pos=37},
    {val=196, pos=36},
    {val=181, pos=35},
    {val=168, pos=34},
    {val=155, pos=33},
    {val=155, pos=32},
    {val=143, pos=31},
    {val=130, pos=30},
    {val=119, pos=29},
    {val=108, pos=28},
    {val=98, pos=27},
    {val=87, pos=26},
    {val=78, pos=25},
    {val=69, pos=24},
    {val=61, pos=23},
    {val=53, pos=22},
    {val=46, pos=21},
    {val=39, pos=20},
    {val=33, pos=19},
    {val=27, pos=18},
    {val=22, pos=17},
    {val=17, pos=16},
    {val=13, pos=15},
    {val=9, pos=14},
    {val=6, pos=13},
    {val=4, pos=12},
    {val=2, pos=11},
    {val=1, pos=10}
}

function find_angle(current, target)
    if current == target then
        return 0
    end

    local diff = math.abs(current - target)
    local dir = 1
    if current > target then
        dir = -1
    end
    local wrapped_diff = 65536 - diff
    if wrapped_diff < diff then
        diff = wrapped_diff
        dir = dir * -1
    end

    local i = 1
    while i <= #angles do
        if angles[i].val <= diff then
            return angles[i].pos * dir
        end
        i = i + 1
    end
    return 0
end

while true do
    joypad.setanalog({["X Axis"]=-x, ["Y Axis"]=y}, 1)

    curr_frame = mainmemory.read_u32_be(addr_visual_frame) - original_frame

    if curr_frame ~= last_frame then
        local v_angle = mainmemory.read_s16_be(addr_cup_vertical)
        local h_angle = mainmemory.read_s16_be(addr_cup_horizontal)
        if v_angle == y_target and h_angle == x_target then
            joypad.setanalog({["X Axis"]=0, ["Y Axis"]=0}, 1)
            client.pause()
            break
        end
        y = find_angle(v_angle, y_target)
        x = find_angle(h_angle, x_target)
    end

    emu.frameadvance()
end
