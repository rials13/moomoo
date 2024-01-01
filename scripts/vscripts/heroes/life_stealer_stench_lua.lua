life_stealer_stench_lua = class({})
LinkLuaModifier( "modifier_life_stealer_stench_lua", "heroes/modifier_life_stealer_stench_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function life_stealer_stench_lua:GetIntrinsicModifierName()
    return "modifier_life_stealer_stench_lua"
end