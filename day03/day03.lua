local function prio_score(c)
    local code = c:byte()
    if code >= string.byte("a") then
        return code - string.byte("a") + 1
    else
        return code - string.byte("A") + 27
    end
end

-- Part 1
local prio_sum_1 = 0
for line in io.lines("input.txt") do
    local a = line:sub(0, #line / 2)
    local b = line:sub(#line / 2 + 1)
    local same = ""
    for i = 1, #a, 1 do
        for j = 1, #a, 1 do
            if a:sub(i, i) == b:sub(j, j) then
                same = a:sub(i, i)
            end
        end
    end

    prio_sum_1 = prio_sum_1 + prio_score(same)
end

print("Part 1: " .. prio_sum_1)

-- Part 2
local prio_sum_2 = 0
local elfs = {}
for line in io.lines("input.txt") do
    table.insert(elfs, line)
    if #elfs == 3 then
        local same = ""
        for i = 1, #elfs[1], 1 do
            for j = 1, #elfs[2], 1 do
                for k = 1, #elfs[3], 1 do
                    if elfs[1]:sub(i, i) == elfs[2]:sub(j, j) and elfs[1]:sub(i, i) == elfs[3]:sub(k, k) then
                        same = elfs[1]:sub(i, i)
                    end
                end
            end
        end
        elfs = {}
        prio_sum_2 = prio_sum_2 + prio_score(same)
    end
end

print("Part 2: " .. prio_sum_2)
