local _, addon = ...

local checker = {}

function checker:GetShortages()
    local result = {}

    local checkFn = function(numDungeons, infoFn)
        for i = 1, numDungeons do
            local dungeonId, dungeonName = infoFn(i)
            local _, joinable = IsLFGDungeonJoinable(dungeonId)
            if joinable then
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
    end

    if LfgMonConf.monitorDungeons then
        checkFn(GetNumRandomDungeons(), GetLFGRandomDungeonInfo)
    end
    if LfgMonConf.monitorRaids then
        checkFn(GetNumRFDungeons(), GetRFDungeonInfo)
    end

    return result
end

function checker:checkDungeon(dungeonId)
    if type(dungeonId) == "number" then
        local eligible, tank, healer, damage, itemCount =
            GetLFGRoleShortageRewards(dungeonId, LFG_ROLE_SHORTAGE_RARE)
        if eligible and (tank or healer or damage) and itemCount > 0 then
            if LfgMonConf.considerLockout and self:isLocked(dungeonId) then
                return false
            end
            return true, tank, healer, damage
        end
    end
    return false
end

--[[
    We consider the dungeon locked if all bosses are killed.
    If at least one boss is alive, there are benefits for the player
    to queue up and take the extra rewards.
]]
function checker:isLocked(dungeonId)
    local locked = false
    for encounterId = 1, GetLFGDungeonNumEncounters(dungeonId) do
        local _, _, isKilled = GetLFGDungeonEncounterInfo(dungeonId, encounterId)
        locked = locked or isKilled
    end
    return locked
end

addon.checker = checker
