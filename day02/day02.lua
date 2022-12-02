-- A,X for Rock, B,Y for Paper, and C,Z for Scissors

local map = { ["X"] = "A", ["Y"] = "B", ["Z"] = "C" }
local score = { ["A"] = 1, ["B"] = 2, ["C"] = 3 }
local wins = { ["A"] = "B", ["B"] = "C", ["C"] = "A" }
local loses = { ["A"] = "C", ["B"] = "A", ["C"] = "B" }

local total_score = 0
local total_score_2 = 0

for line in io.lines("input.txt") do
    for opp, j in string.gmatch(line, "(%a) (%a)") do
        local pl = map[j]

        -- Part 1
        if opp == pl then
            total_score = total_score + score[pl] + 3
        elseif (opp == "A" and pl == "B") or (opp == "B" and pl == "C") or (opp == "C" and pl == "A") then
            total_score = total_score + score[pl] + 6
        else
            total_score = total_score + score[pl] + 0
        end

        -- Part 2
        if j == "Y" then
            total_score_2 = total_score_2 + score[opp] + 3
        elseif j == "Z" then
            total_score_2 = total_score_2 + score[wins[opp]] + 6
        else
            total_score_2 = total_score_2 + score[loses[opp]] + 0
        end
    end
end

print("Part 1: " .. total_score .. ", Part 2: " .. total_score_2)
