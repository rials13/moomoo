item_bloodstone_moo = class({})
LinkLuaModifier( "item_bloodstone_moo_modifier", "items/item_bloodstone_moo_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_bloodstone_moo_modifier_stack", "items/item_bloodstone_moo_modifier_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_bloodstone_moo:GetIntrinsicModifierName()
    return "item_bloodstone_moo_modifier"
end