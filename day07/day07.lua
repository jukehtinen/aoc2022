local dir_sizes = {}
local stack = {}

for line in io.lines("input.txt") do
    local cd = line:match("$ cd (.+)")
    if cd ~= nil then
        if cd == ".." then
            table.remove(stack, #stack)
        else
            if #stack == 0 then
                table.insert(stack, cd)
            else
                table.insert(stack, stack[#stack] .. cd .. "/")
            end
        end
    end

    local file = line:match("(%d+) (.+)")
    if file ~= nil then
        for _, dir in ipairs(stack) do
            if dir_sizes[dir] == nil then dir_sizes[dir] = 0 end
            dir_sizes[dir] = dir_sizes[dir] + tonumber(file)
        end
    end
end

local total = 0
for _, value in pairs(dir_sizes) do
    if value <= 100000 then total = total + value end
end
print("Part 1: " .. total)

local required_space = 30000000
local available_space = 70000000 - dir_sizes["/"]
local smallest = 70000000
for _, value in pairs(dir_sizes) do
    if available_space + value >= required_space and value < smallest then
        smallest = value
    end
end
print("Part 2: " .. smallest)
