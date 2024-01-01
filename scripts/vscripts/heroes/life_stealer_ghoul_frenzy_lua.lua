life_stealer_ghoul_frenzy_lua = class({})
LinkLuaModifier( "modifier_life_stealer_ghoul_frenzy_lua", "heroes/modifier_life_stealer_ghoul_frenzy_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function life_stealer_ghoul_frenzy_lua:GetIntrinsicModifierName()
    return "modifier_life_stealer_ghoul_frenzy_lua"
end