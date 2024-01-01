item_moo_moo_axe = class({})
LinkLuaModifier( "item_item_moo_moo_axe_modifier", "items/item_moo_moo_axe_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_bashed_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_moo_axe:GetIntrinsicModifierName()
    return "item_moo_moo_axe_modifier"
end