local _, addon = ...

addon.tankIcon = CreateAtlasMarkup("roleicon-tiny-tank", 16, 16)
addon.healerIcon = CreateAtlasMarkup("roleicon-tiny-healer", 16, 16)
addon.damageIcon = CreateAtlasMarkup("roleicon-tiny-dps", 16, 16)

--[[
    The shortages table format (see below) can contain fully false
    info elements. We can use this helper function to determine
    if there is an actual shortage in any of the dungeons.
    
    shortages = {
        ["Dungeon Name"] = {
            tank = boolean,
            healer = boolean,
            damage = boolean,
        },
    }
]]
addon.hasShortage = function(shortages)
    for _, info in pairs(shortages) do
        if info.tank or info.healer or info.damage then
            return true
        end
    end
    return false
end
