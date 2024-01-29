local _, addon = ...

local info = {}

local role = addon.role

local tankIcon = "Interface\\Icons\\INV_Shield_06"
local healerIcon = "Interface\\Icons\\Spell_Holy_Heal"
local damageIcon = "Interface\\Icons\\INV_Sword_65"

local textureFormat = {
    width = 20,
    height = 20,
    anchor = Enum.TooltipTextureAnchor.LeftCenter,
    region = Enum.TooltipTextureRelativeRegion.RightLine,
    margin = {
        left = 10,
        right = 10,
    },
}

function info:SetTooltipContent(shortages)
    GameTooltip:AddLine("Extra rewards available", 0, 1, 0)
    for dungeonName, shortage in pairs(shortages) do
        self:addLineIfNeeded(dungeonName, shortage.tank, role:canTank(), tankIcon)
        self:addLineIfNeeded(dungeonName, shortage.healer, role:canHeal(), healerIcon)
        self:addLineIfNeeded(dungeonName, shortage.damage, role:canDamage(), damageIcon)
    end
end

function info:addLineIfNeeded(dungeonName, isShortage, canPerform, icon)
    if isShortage and canPerform then
        GameTooltip:AddDoubleLine(dungeonName, " ")
        GameTooltip:AddTexture(icon, textureFormat)
    end
end

addon.info = info
