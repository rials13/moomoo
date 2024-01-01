item_sennor_kris = class({})
LinkLuaModifier( "item_sennor_kris_modifier", "items/item_sennor_kris_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_sennor_kris_modifier_stack", "items/item_sennor_kris_modifier_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_sennor_kris:GetIntrinsicModifierName()
    return "item_sennor_kris_modifier"
end