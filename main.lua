for i = 1, GetNumRandomDungeons() do
    local dungeonId, dungeonName = GetLFGRandomDungeonInfo(i)
    if type(dungeonId) == "number" then
        for shortageType = 1, LFG_ROLE_NUM_SHORTAGE_TYPES do
            local eligible, forTank, forHealer, forDamage, itemCount, money, xp = GetLFGRoleShortageRewards(dungeonId, shortageType)
            if eligible then
                print(dungeonId, dungeonName, forTank, forHealer, forDamage, itemCount, money, xp)
            end
        end
    end
end

--if ( not IsInGroup(LE_PARTY_CATEGORY_HOME) ) then
