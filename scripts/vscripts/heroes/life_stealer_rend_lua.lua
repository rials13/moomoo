life_stealer_rend_lua = class({})
LinkLuaModifier( "modifier_life_stealer_rend_lua", "heroes/modifier_life_stealer_rend_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_life_stealer_rend_lua_debuff", "heroes/modifier_life_stealer_rend_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function life_stealer_rend_lua:GetIntrinsicModifierName()
    return "modifier_life_stealer_rend_lua"
end