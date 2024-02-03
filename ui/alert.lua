local _, addon = ...

local alert = {}

local notifier = addon.notifier

function alert:Init()
    notifier:Subscribe(function(payload)
        if LfgMonConf.playAlert then
            self:handleUpdate(payload.new)
        end
    end)
end

function alert:handleUpdate(shortages)
    if addon.hasShortage(shortages) then
        DEFAULT_CHAT_FRAME:AddMessage("Extra rewards are available:", 0, 1, 1)
        for dungeonName, shortage in pairs(shortages) do
            if shortage.tank then
                self:printShortageString(dungeonName, addon.tankIcon)
            end
            if shortage.healer then
                self:printShortageString(dungeonName, addon.healerIcon)
            end
            if shortage.damage then
                self:printShortageString(dungeonName, addon.damageIcon)
            end
        end
        PlaySound(SOUNDKIT.TELL_MESSAGE)
    end
end

function alert:printShortageString(dungeonName, icon)
    local msg = string.format("  %s   %s", icon, dungeonName)
    DEFAULT_CHAT_FRAME:AddMessage(msg)
end

addon.alert = alert
