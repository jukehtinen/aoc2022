local current_sum = 0
local elfs = {}
for line in io.lines("input.txt") do
    if line ~= "" then
        current_sum = current_sum + tonumber(line)
    else
        table.insert(elfs, current_sum)
        current_sum = 0
    end
end

-- Part 1
table.sort(elfs)
print("Part 1: " .. elfs[#elfs])

-- Part 2
print("Part 1: " .. elfs[#elfs] + elfs[#elfs - 1] + elfs[#elfs - 2])
