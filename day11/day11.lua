local function split(s, tf)
    local items = {}
    s:gsub("([^,]+)", function(c) items[#items + 1] = tf(c) end)
    return items
end

local function get_initial()
    local monkeys = {}
    local lines = {}
    for line in io.lines("input.txt") do table.insert(lines, line) end

    for i = 1, #lines, 7 do
        local monkey = tonumber(lines[i + 0]:match("Monkey (%d+):"))
        table.insert(monkeys, {
            op = lines[i + 2]:match(".+Operation: (.+)"),
            test = tonumber(lines[i + 3]:match(".+Test: divisible by (%d+)")),
            if_true = tonumber(lines[i + 4]:match(".+If true: throw to monkey (%d+)")),
            if_false = tonumber(lines[i + 5]:match(".+If false: throw to monkey (%d+)")),
            items = split(lines[i + 1]:match(".+Starting items: (.+)"), tonumber),
            inspects = 0
        })
    end
    return monkeys
end

local function do_op(monkey, item)
    local n = monkey.op:gsub("old", item)
    local l, op, r = n:match("new = (%d+) (.+) (%d+)")
    if op == "+" then return tonumber(l) + tonumber(r) end
    if op == "*" then return tonumber(l) * tonumber(r) end
    print("error")
end

local monkeys = get_initial()
for i = 1, 20, 1 do
    for mi, monkey in ipairs(monkeys) do
        for ii, item in ipairs(monkey.items) do
            local worry = math.floor(do_op(monkey, item) / 3)
            monkey.inspects = monkey.inspects + 1
            if worry % monkey.test == 0 then
                table.insert(monkeys[monkey.if_true + 1].items, worry)
            else
                table.insert(monkeys[monkey.if_false + 1].items, worry)
            end
        end
        monkeys[mi].items = {}
    end
end
table.sort(monkeys, function(m1, m2) return m1.inspects > m2.inspects end)
print("Part 1: " .. monkeys[1].inspects * monkeys[2].inspects)

monkeys = get_initial()
local least_common_mult = 1
for _, monkey in ipairs(monkeys) do least_common_mult = least_common_mult * monkey.test end

for i = 1, 10000, 1 do
    for mi, monkey in ipairs(monkeys) do
        for ii, item in ipairs(monkey.items) do
            local worry = math.floor(do_op(monkey, item) % least_common_mult)
            monkey.inspects = monkey.inspects + 1
            if worry % monkey.test == 0 then
                table.insert(monkeys[monkey.if_true + 1].items, worry)
            else
                table.insert(monkeys[monkey.if_false + 1].items, worry)
            end
        end
        monkeys[mi].items = {}
    end
end
table.sort(monkeys, function(m1, m2) return m1.inspects > m2.inspects end)
print("Part 2: " .. monkeys[1].inspects * monkeys[2].inspects)
