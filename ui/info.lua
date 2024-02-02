local _, addon = ...

local info = {}

local role = addon.role

local tankIcon = CreateAtlasMarkup("roleicon-tiny-tank", 16, 16)
local healerIcon = CreateAtlasMarkup("roleicon-tiny-healer", 16, 16)
local damageIcon = CreateAtlasMarkup("roleicon-tiny-dps", 16, 16)

function info:SetTooltipContent(shortages)
    GameTooltip:AddLine("Extra rewards available", 0, 1, 1)
    for dungeonName, shortage in pairs(shortages) do
        self:addLineIfNeeded(dungeonName, shortage.tank, role.canTank, tankIcon)
        self:addLineIfNeeded(dungeonName, shortage.healer, role.canHeal, healerIcon)
        self:addLineIfNeeded(dungeonName, shortage.damage, role.canDamage, damageIcon)
    end
end

function info:addLineIfNeeded(dungeonName, isShortage, canPerform, icon)
    if isShortage and canPerform then
        GameTooltip:AddDoubleLine(dungeonName, icon)
    end
end

addon.info = info
