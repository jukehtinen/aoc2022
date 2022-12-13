local function parse_next(a)
    local ix = 1
    while true do
        if a:sub(ix, ix) == "[" then
            local open_brace = 0
            for i = ix + 1, #a, 1 do
                if a:sub(i, i) == "[" then open_brace = open_brace + 1 end
                if a:sub(i, i) == "]" then
                    if open_brace == 0 then
                        return { type = 1, val = a:sub(ix + 1, i - 1), n = i + 1 }
                    else
                        open_brace = open_brace - 1
                    end
                end
            end
        elseif a:sub(ix, ix) == "," then ix = ix + 1
        else
            local x, y = a:find("%d+")
            return { type = 0, val = a:sub(x, y), n = y + 1 }
        end
    end
end

local function compare(a, b)
    while a ~= "" and b ~= "" do
        local i1 = parse_next(a)
        local i2 = parse_next(b)
        if i1.type ~= i2.type then
            i1.type = 1
            i2.type = 1
        end
        if i1.type == 0 then
            if tonumber(i1.val) < tonumber(i2.val) then return { continue = false, wrong = false } end
            if tonumber(i1.val) > tonumber(i2.val) then return { continue = false, wrong = true } end
        end
        if i1.type == 1 then
            local res = compare(i1.val, i2.val)
            if not res.continue then return res end
        end
        a = a:sub(i1.n)
        b = b:sub(i2.n)
    end

    if a == "" and b ~= "" then return { continue = false, wrong = false } end
    if a ~= "" and b == "" then return { continue = false, wrong = true } end
    return { continue = true, wrong = false }
end

local a = ""
local b = ""
local right_order = 0
local index = 1
for line in io.lines("input.txt") do
    if a == "" then a = line
    elseif b == "" then b = line
    else
        local res = compare(a, b)
        if not res.wrong then right_order = right_order + index end
        a = ""
        b = ""
        index = index + 1
    end
end
print("Part 1: " .. right_order)

local items = { "[[2]]", "[[6]]" }
for line in io.lines("input.txt") do if line ~= "" then table.insert(items, line) end end
table.sort(items, function(x, y) return compare(x, y).wrong end)
local rev = {}
for i = #items, 1, -1 do rev[#rev + 1] = items[i] end

local index2 = 0
local index6 = 0
for ix, value in ipairs(rev) do
    if value == "[[2]]" then index2 = ix end
    if value == "[[6]]" then index6 = ix end
end
print("Part 2: " .. index2 * index6)
