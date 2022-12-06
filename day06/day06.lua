local function load_lines()
    local lines = {}
    for line in io.lines("input.txt") do table.insert(lines, line) end
    return lines
end

local function item_count(tbl)
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count
end

local input = load_lines()[1]

-- Part 1
for i = 1, #input, 1 do
    local set = {}
    set[input:sub(i + 0, i + 0)] = 1
    set[input:sub(i + 1, i + 1)] = 1
    set[input:sub(i + 2, i + 2)] = 1
    set[input:sub(i + 3, i + 3)] = 1

    if item_count(set) == 4 then
        print("Part 1: ", i + 3)
        break
    end
end

-- Part 2
for i = 1, #input, 1 do
    local set = {}
    for j = 0, 13, 1 do
        set[input:sub(i + j, i + j)] = 1
    end

    if item_count(set) == 14 then
        print("Part 2: ", i + 13)
        break
    end
end
