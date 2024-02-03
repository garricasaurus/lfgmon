local _, addon = ...

local info = {}

function info:SetTooltipContent(shortages)
    GameTooltip:AddLine("Extra rewards available", 0, 1, 1)
    for dungeonName, shortage in pairs(shortages) do
        self:addLineIfNeeded(dungeonName, shortage.tank, addon.tankIcon)
        self:addLineIfNeeded(dungeonName, shortage.healer, addon.healerIcon)
        self:addLineIfNeeded(dungeonName, shortage.damage, addon.damageIcon)
    end
end

function info:addLineIfNeeded(dungeonName, isShortage, icon)
    if isShortage then
        GameTooltip:AddDoubleLine(dungeonName, icon)
    end
end

addon.info = info
