SLASH_LFGMON1 = "/lfgmon"

local name, addon = ...

local commands = {}

local function SlashCommandHandler(msg, _)
    if msg then
        local command = commands[msg]
        if command then
            command(commands)
        end
    else
        commands:config()
    end
end

function commands:config()
    Settings.OpenToCategory(name)
end

function commands:reset()
    LfgMonConf = addon.defaults
    addon.icon:ResetPosition()
end

SlashCmdList["LFGMON"] = SlashCommandHandler
