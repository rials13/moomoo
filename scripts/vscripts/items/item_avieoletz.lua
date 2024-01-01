item_avieoletz = class({})
LinkLuaModifier( "item_avieoletz_modifier", "items/item_avieoletz_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_avieoletz_modifier_stack", "items/item_avieoletz_modifier_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_avieoletz:GetIntrinsicModifierName()
    return "item_avieoletz_modifier"
end