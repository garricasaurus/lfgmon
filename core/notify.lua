local _, addon = ...

local notify = {}

function notify:CreateAlert()
    if LfgMonConf.playAlert then
        DEFAULT_CHAT_FRAME:AddMessage(addon.AlertMessage, 0, 1, 1)
        PlaySound(SOUNDKIT.TELL_MESSAGE)
    end
end

addon.notify = notify