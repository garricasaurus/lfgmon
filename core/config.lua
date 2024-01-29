local _, addon = ...

local config = {}

function config:Init()
    LfgMonConf = LfgMonConf or {}
    for k, v in pairs(addon.defaults) do
        if not LfgMonConf[k] then
            LfgMonConf[k] = v
        end
    end
end

addon.config = config