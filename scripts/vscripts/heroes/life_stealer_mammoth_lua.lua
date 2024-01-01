life_stealer_mammoth_lua = class({})
LinkLuaModifier( "modifier_life_stealer_mammoth_lua", "heroes/modifier_life_stealer_mammoth_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function life_stealer_mammoth_lua:GetIntrinsicModifierName()
    return "modifier_life_stealer_mammoth_lua"
end