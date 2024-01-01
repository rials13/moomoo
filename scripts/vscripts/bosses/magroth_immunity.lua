magroth_immunity = class({})
LinkLuaModifier( "magroth_immunity_modifier", "bosses/magroth_immunity_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "magroth_immunity_modifier_effect", "bosses/magroth_immunity_modifier_effect", LUA_MODIFIER_MOTION_NONE )
--------------------------------------------------------------------------------
-- Passive Modifier
function magroth_immunity:GetIntrinsicModifierName()
    return "magroth_immunity_modifier"
end