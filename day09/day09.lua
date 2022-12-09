local function add_visited(t, tail_visited)
    for _, value in ipairs(tail_visited) do
        if value[1] == t[1] and value[2] == t[2] then return end
    end
    table.insert(tail_visited, t)
end

local function run(knot_count)
    local tail_visited = {}
    local h = { 0, 0 }
    local t = {}
    for i = 1, knot_count, 1 do table.insert(t, { 0, 0 }) end

    for line in io.lines("input.txt") do
        local dir, moves = line:match("(%a) (%d+)")
        for i = 1, tonumber(moves), 1 do
            if dir == "R" then h = { h[1] + 1, h[2] } end
            if dir == "L" then h = { h[1] - 1, h[2] } end
            if dir == "U" then h = { h[1], h[2] - 1 } end
            if dir == "D" then h = { h[1], h[2] + 1 } end

            local prev = h
            for j, knot in ipairs(t) do
                local dx = knot[1] - prev[1];
                local dy = knot[2] - prev[2];
                local dist = math.floor(math.sqrt(dx * dx + dy * dy))
                if dist > 1 then
                    if prev[1] == knot[1] then
                        if prev[2] > knot[2] then knot = { knot[1], knot[2] + 1 } else knot = { knot[1], knot[2] - 1 } end
                    elseif prev[2] == knot[2] then
                        if prev[1] > knot[1] then knot = { knot[1] + 1, knot[2] } else knot = { knot[1] - 1, knot[2] } end
                    else
                        if prev[2] > knot[2] then knot = { knot[1], knot[2] + 1 } else knot = { knot[1], knot[2] - 1 } end
                        if prev[1] > knot[1] then knot = { knot[1] + 1, knot[2] } else knot = { knot[1] - 1, knot[2] } end
                    end
                    t[j] = knot
                end
                prev = knot
            end
            add_visited(t[#t], tail_visited)
        end
    end

    local visited = 0
    for _, _ in ipairs(tail_visited) do visited = visited + 1 end
    return visited
end

print("Part 1: " .. run(1))
print("Part 2: " .. run(9))
