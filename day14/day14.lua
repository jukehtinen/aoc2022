local function read_map()
    local map = {}
    local lowest_point = 0
    for line in io.lines("input.txt") do
        local prev = nil
        for a, b in line:gmatch("(%d+),(%d+)") do
            local pt = { tonumber(a), tonumber(b) }
            if pt[2] > lowest_point then lowest_point = pt[2] end
            if prev ~= nil then
                for y = math.min(pt[2], prev[2]), math.max(pt[2], prev[2]), 1 do
                    for x = math.min(pt[1], prev[1]), math.max(pt[1], prev[1]), 1 do
                        map[x .. "," .. y] = 1
                    end
                end
            end
            prev = pt
        end
    end
    return map, lowest_point
end

local function simulate(is_pt1)
    local map, lowest_point = read_map()
    local sand_at_rest = 0
    local done = false
    local floor = lowest_point + 2

    while true do
        local x = 500
        local y = 0
        while true do
            if map[x .. "," .. y + 1] == nil and y + 1 < floor then
                y = y + 1
            elseif map[x - 1 .. "," .. y + 1] == nil and y + 1 < floor then
                x = x - 1
                y = y + 1
            elseif map[x + 1 .. "," .. y + 1] == nil and y + 1 < floor then
                x = x + 1
                y = y + 1
            else
                map[x .. "," .. y] = 1
                sand_at_rest = sand_at_rest + 1
                if x == 500 and y == 0 then done = true end
                break
            end
            if is_pt1 and y >= lowest_point then done = true break end
        end
        if done then break end
    end
    return sand_at_rest
end

print("Part 1: " .. simulate(true))
print("Part 2: " .. simulate(false))
