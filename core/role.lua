local _, addon = ...

local role = {
    playerRoles = {}
}

local TANK = "TANK"
local HEALER = "HEALER"
local DAMAGE = "DAMAGER"

function role:canTank()
    return self.playerRoles[TANK]
end

function role:canHeal()
    return self.playerRoles[HEALER]
end

function role:canDamage()
    return self.playerRoles[DAMAGE]
end

local function getPlayerRoles()
    local result = {}
    for specIndex = 1, GetNumSpecializations() do
        local roleName = GetSpecializationRole(specIndex)
        if roleName then
            result[roleName] = true
        end
    end
    return result
end

local function init()
    if C_SpecializationInfo.IsInitialized() then
        role.playerRoles = getPlayerRoles()
    else
        C_Timer.After(1, init)
    end
end

init()

addon.role = role
