local name, addon = ...

local main = {}

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
    LfgMonConf = LfgMonConf or addon.defaults
    -- initialize required components
    for _, comp in ipairs({
        addon.config,
        addon.settings,
        addon.alert,
        addon.icon,
        addon.notifier
    }) do
        comp:Init()
    end
end

addon.main = main