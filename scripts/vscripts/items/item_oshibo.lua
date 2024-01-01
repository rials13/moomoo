item_oshibo = class({})
LinkLuaModifier( "item_oshibo_modifier", "items/item_oshibo_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_oshibo_modifier_stack", "items/item_oshibo_modifier_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_oshibo:GetIntrinsicModifierName()
    return "item_oshibo_modifier"
end