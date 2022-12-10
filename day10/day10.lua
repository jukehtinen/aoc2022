local function split(s)
    local items = {}
    s:gsub("([^ ]+)", function(c) items[#items + 1] = c end)
    return items
end

local x = 1
local cycles = 0
local next_check_at = 20
local signal_str_sum = 0
local current_row = ""
local part2_picture = ""

local function do_cycles(c)
    for i = 1, c, 1 do
        cycles = cycles + 1

        -- Part 1
        if cycles == next_check_at then
            signal_str_sum = signal_str_sum + cycles * x
            next_check_at = next_check_at + 40
        end

        -- Part 2
        local row = cycles % 40
        if row == 0 then
            part2_picture = part2_picture .. current_row .. "\n"
            current_row = ""
        else
            if row >= x and row < x + 3 then
                current_row = current_row .. "#"
            else
                current_row = current_row .. "."
            end
        end
    end
end

for line in io.lines("input.txt") do
    local op = split(line)
    if op[1] == "noop" then do_cycles(1) end
    if op[1] == "addx" then
        do_cycles(2)
        x = x + tonumber(op[2])
    end
end

print("Part 1: " .. signal_str_sum)
print("Part 2:\n" .. part2_picture)
