local name, addon = ...

local frame = CreateFrame("Frame", "LfgMonSettingsFrame")

local function createText(parent, text, style, width)
    local s = parent:CreateFontString(nil, "ARTWORK", style)
    s:SetWidth(width or 250)
    s:SetJustifyH("LEFT")
    s:SetText(text)
    return s
end

local function createCheckbox(parent, text)
    local chekbox = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    chekbox["text"]:SetText(text)
    return chekbox
end

local title = createText(frame, addon.SettingsTitle, "GameFontNormalLarge")
local monitorDungeonsCheckbox = createCheckbox(frame, addon.MonitorDungeonsText)
local monitorRaidsCheckbox = createCheckbox(frame, addon.MonitorRaidsText)

-- align controls
title:SetPoint("TOPLEFT", 20, -20)
monitorDungeonsCheckbox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -40)
monitorRaidsCheckbox:SetPoint("TOPLEFT", monitorDungeonsCheckbox, "BOTTOMLEFT", 0, -40)


function frame:OnRefresh()
    monitorDungeonsCheckbox:SetChecked(LfgMonConf.monitorDungeons)
    monitorRaidsCheckbox:SetChecked(LfgMonConf.monitorRaids)
end

function frame:OnCommit()
    LfgMonConf.monitorDungeons = monitorDungeonsCheckbox:GetChecked()
    LfgMonConf.monitorRaids = monitorRaidsCheckbox:GetChecked()
end

function frame:OnDefault()
    LfgMonConf = addon.defaults
end

-- integrate with options menu
local settings = Settings.RegisterCanvasLayoutCategory(frame, name)
settings.ID = name

Settings.RegisterAddOnCategory(settings)