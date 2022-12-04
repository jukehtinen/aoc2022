local fully_contains = 0
local overlaps = 0

for line in io.lines("input.txt") do
    for a1, a2, b1, b2 in line:gmatch("(%d+)%-(%d+),(%d+)%-(%d+)") do
        -- Part 1
        if (tonumber(a1) >= tonumber(b1) and tonumber(a2) <= tonumber(b2)) or
            (tonumber(b1) >= tonumber(a1) and tonumber(b2) <= tonumber(a2)) then
            fully_contains = fully_contains + 1
        end

        -- Part 2
        if not (tonumber(a2) < tonumber(b1) or tonumber(a1) > tonumber(b2)) then
            overlaps = overlaps + 1
        end
    end
end

print("Part 1: " .. fully_contains)
print("Part 2: " .. overlaps)
