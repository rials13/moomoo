item_tectonic = class({})
LinkLuaModifier( "item_tectonic_modifier", "items/item_tectonic_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_bashed_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_tectonic:GetIntrinsicModifierName()
    return "item_tectonic_modifier"
end