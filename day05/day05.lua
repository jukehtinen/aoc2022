local function load_lines()
    local lines = {}
    for line in io.lines("input.txt") do table.insert(lines, line) end
    return lines
end

local function parse_crates(lines)
    local stacks = {}
    local last = 0
    for i, line in ipairs(lines) do
        if line == "" then
            last = i
            break
        end

        local line_pos = 0
        while line_pos < #line do
            local crate = line:sub(line_pos, line_pos + 4)
            local inx = crate:find("(%a)")
            if inx ~= nil then
                local stack_index = line_pos // 4 + 1
                if stacks[stack_index] == nil then stacks[stack_index] = {} end
                table.insert(stacks[stack_index], crate:sub(inx, inx))
            end
            line_pos = line_pos + 4
        end
    end

    -- Reverse stacks
    for i, v in ipairs(stacks) do
        local reversed = {}
        for j = #v, 1, -1 do reversed[#reversed + 1] = v[j] end
        stacks[i] = reversed
    end

    return stacks, last + 1
end

local lines = load_lines()

-- Part 1
local stacks, last = parse_crates(lines)
for l = last, #lines, 1 do
    local _, _, move, from, to = lines[l]:find("move (%d+) from (%d+) to (%d+)")
    for i = 1, tonumber(move), 1 do
        local moved = table.remove(stacks[tonumber(from)], #stacks[tonumber(from)])
        table.insert(stacks[tonumber(to)], moved)
    end
end

local tops = ""
for _, v in ipairs(stacks) do tops = tops .. v[#v] end
print("Part 1: " .. tops)

-- Part 2
stacks, last = parse_crates(lines)
for l = last, #lines, 1 do
    local _, _, move, from, to = lines[l]:find("move (%d+) from (%d+) to (%d+)")
    local pile = {}
    for i = 1, tonumber(move), 1 do
        local moved = table.remove(stacks[tonumber(from)], #stacks[tonumber(from)])
        table.insert(pile, moved)
    end
    for i = #pile, 1, -1 do
        table.insert(stacks[tonumber(to)], pile[i])
    end
end

tops = ""
for _, v in ipairs(stacks) do tops = tops .. v[#v] end
print("Part 2: " .. tops)
