local _, addon = ...

local notifier = {
    subscribers = {}
}

local checker = addon.checker
local role = addon.role

function notifier:Init()
    self:refresh()
    C_Timer.NewTicker(LfgMonConf.checkFrequency, function()
        self:refresh()
    end)
end

function notifier:Subscribe(callbackFn)
    table.insert(self.subscribers, callbackFn)
end

function notifier:refresh()
    local shortages = {}
    if not IsInGroup() then
        shortages = self:filterRole(checker:GetShortages())
    end
    self:notify(shortages)
end

function notifier:notify(shortages)
    local new = self:filterNew(shortages)
    for _, subscriber in ipairs(self.subscribers) do
        -- Payload contains copies of the update. This prevents subscribers
        -- from changing the data for subsequent subscribers.
        local payload = {
            current = CopyTable(shortages),
            new = CopyTable(new),
        }
        subscriber(payload)
    end
end

function notifier:filterNew(shortages)
    local result = CopyTable(shortages)
    local previousShortages = self.previousShortages or {}
    -- set substract (current - previous)
    for dungeonName, previousShortage in pairs(previousShortages) do
        local shortage = result[dungeonName] or {}
        shortage.tank = shortage.tank and not previousShortage.tank
        shortage.healer = shortage.healer and not previousShortage.healer
        shortage.damage = shortage.damage and not previousShortage.damage
    end
    self.previousShortages = shortages
    return result
end

function notifier:filterRole(shortages)
    local result = CopyTable(shortages)
    for _, shortage in pairs(result) do
        shortage.tank = shortage.tank and role.canTank
        shortage.healer = shortage.healer and role.canHeal
        shortage.damage = shortage.damage and role.canDamage
    end
    return result
end

addon.notifier = notifier
