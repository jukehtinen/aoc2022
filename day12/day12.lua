local map = {}
local width = 0
local height = 0
local start = 0
local goal = 0
local bs = {}

for line in io.lines("input.txt") do
    width = #line
    height = height + 1
    for i = 1, #line, 1 do
        local c = line:sub(i, i)
        if c == "S" then
            start = #map + 1
            c = "a"
        end
        if c == "E" then
            goal = #map + 1
            c = "z"
        end
        -- Collect 'b's for Part 2. It wants route from 'a', but there are far fewer 'b's (the find_path is extremely slow)
        if c == "b" then table.insert(bs, #map + 1) end
        table.insert(map, c:byte())
    end
end

local function priority_insert(tbl, v, prio)
    table.insert(tbl, { val = v, prio = prio })
    table.sort(tbl, function(a, b) return a.prio < b.prio end)
end

local function find_path(start, target)
    local frontier = {}
    local came_from = {}
    local cost_so_far = {}

    came_from[start] = -1
    cost_so_far[start] = 0
    priority_insert(frontier, start, 0)

    local dirs = { { 0, 1 }, { 0, -1 }, { 1, 0 }, { -1, 0 } }

    while #frontier ~= 0 do

        local current = table.remove(frontier, #frontier).val - 1
        local current_height = map[current + 1]

        local x = current % width
        local y = current // width
        local neighbors = {}
        for _, dir in ipairs(dirs) do
            local tx = x + dir[1]
            local ty = y + dir[2]
            if tx >= 0 and ty >= 0 and tx < width and ty < height then
                local ix = (ty * width + tx) + 1;
                if map[ix] - 1 <= current_height then table.insert(neighbors, ix) end
            end
        end

        for _, n in ipairs(neighbors) do
            local new_cost = cost_so_far[current + 1] + 1
            if cost_so_far[n] == nil or new_cost < cost_so_far[n] then
                cost_so_far[n] = new_cost
                priority_insert(frontier, n, new_cost)
                came_from[n] = current + 1
            end
        end
    end

    return came_from
end

local function path_length(start, target, routes)
    local path = {}
    while target ~= start do
        table.insert(path, target)
        target = routes[target]
        if target == nil then
            path = {}
            break
        end
    end
    return #path
end

print("Part 1: " .. path_length(start, goal, find_path(start, goal)))

local shortest = 9999
for _, value in ipairs(bs) do
    local len = path_length(value, goal, find_path(value, goal))
    if len < shortest then shortest = len end
end
print("Part 2: " .. shortest + 1)
