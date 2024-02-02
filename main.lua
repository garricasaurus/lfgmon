local name, addon = ...

local main = {}

local config = addon.config
local checker = addon.checker
local role = addon.role
local icon = addon.icon

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
        icon:SetShown(self:canParticipate(shortages))
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

addon.defaults = {
    monitorDungeons = true,
    monitorRaids = true,
    checkFrequency = 60,
}

addon.main = main
