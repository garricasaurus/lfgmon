local _, addon = ...

local config = {}

function config:Init()
    LfgMonConf = LfgMonConf or {}
    for k, v in pairs(addon.defaults) do
        if LfgMonConf[k] == nil then
            LfgMonConf[k] = v
        end
    end
end

addon.defaults = {
    monitorDungeons = true,
    monitorRaids = true,
    checkFrequency = 60,
    playAlert = false,
    considerLockout = true,
    ignoreTank = false,
    ignoreHealer = false,
    ignoreDamage = false,
}

addon.config = config