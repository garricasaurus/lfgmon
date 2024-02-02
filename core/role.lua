local _, addon = ...

local role = {
    canTank = false,
    canHeal = false,
    canDamage = false,
}

local function init()
    role.canTank, role.canHeal, role.canDamage =
        UnitGetAvailableRoles("player")
end

init()

addon.role = role
