local name, addon = ...

local main = {}

local config = addon.config
local checker = addon.checker
local role = addon.role
local icon = addon.icon
local notify = addon.notify

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(_, event, ...)
    local handler = main[event]
    if handler then
        handler(main, ...)
    end
end)

function main:ADDON_LOADED(addonName)
    if name ~= addonName then
        return
    end
    config:Init()
    icon:Create()
    icon:SetShown(false)
    main:startTimer()
end

function main:startTimer()
    self:updateShortages()
    C_Timer.NewTicker(LfgMonConf.checkFrequency, function()
        self:updateShortages()
    end)
end

function main:updateShortages()
    local shortages = checker:GetShortages()
    addon.shortages = shortages
    if IsInGroup(LE_PARTY_CATEGORY_HOME) then
        icon:SetShown(false)
    else
        local shownBefore = icon:IsShown()
        local shownAfter = self:canParticipate(shortages)
        if not shownBefore and shownAfter then
            notify:CreateAlert()
        end
        icon:SetShown(shownAfter)
    end
end

function main:canParticipate(shortages)
    for _, shortage in pairs(shortages) do
        if shortage.tank and role.canTank or
            shortage.healer and role.canHeal or
            shortage.damage and role.canDamage then
            return true
        end
    end
    return false
end

addon.main = main
