local map = {}
local size = 0

for line in io.lines("input.txt") do
    size = #line
    for i = 1, #line, 1 do table.insert(map, tonumber(line:sub(i, i))) end
end

local dir = { { 0, 1 }, { 0, -1 }, { -1, 0 }, { 1, 0 } }
local visibles = 0
local hi_scenic_score = 0
for i = 0, size * size - 1, 1 do
    local current_height = map[i + 1]
    local is_visible = false
    local scenic_score = 1
    for _, d in ipairs(dir) do

        local trees_visible = 0
        local pos = { i % size, i // size }

        while true do
            pos = { pos[1] + d[1], pos[2] + d[2] }

            if pos[1] >= 0 and pos[2] >= 0 and pos[1] < size and pos[2] < size then
                local test_height = map[pos[2] * size + pos[1] + 1]
                trees_visible = trees_visible + 1
                if test_height >= current_height then break end
            else
                if is_visible == false then visibles = visibles + 1 end
                is_visible = true
                break
            end
        end
        scenic_score = scenic_score * trees_visible
    end
    if scenic_score > hi_scenic_score then hi_scenic_score = scenic_score end
end

print("Part 1: " .. visibles)
print("Part 2: " .. hi_scenic_score)
