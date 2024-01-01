item_slasher = class({})
LinkLuaModifier( "item_slasher_modifier", "items/item_slasher_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_slasher_modifier_stack", "items/item_slasher_modifier_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_slasher:GetIntrinsicModifierName()
    return "item_slasher_modifier"
end