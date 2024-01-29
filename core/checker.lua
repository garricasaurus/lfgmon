local _, addon = ...

local checker = {}

function checker:GetShortages()
    local result = {}

    local checkFn = function(numDungeons, infoFn)
        for i = 1, numDungeons do
            local dungeonId, dungeonName = infoFn(i)
            local shortage, tank, healer, damage = self:checkDungeon(dungeonId)
            if dungeonName and shortage then
                result[dungeonName] = {
                    tank = tank,
                    healer = healer,
                    damage = damage,
                }
            end
        end
    end

    checkFn(GetNumRandomDungeons(), GetLFGRandomDungeonInfo)
    checkFn(GetNumRFDungeons(), GetRFDungeonInfo)

    return result
end

function checker:checkDungeon(dungeonId)
    if type(dungeonId) == "number" then
        local eligible, tank, healer, damage, itemCount =
            GetLFGRoleShortageRewards(dungeonId, LFG_ROLE_SHORTAGE_RARE)
        if eligible and (tank or healer or damage) and itemCount > 0 then
            return true, tank, healer, damage
        end
    end
    return false
end

addon.checker = checker
