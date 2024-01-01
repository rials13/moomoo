item_krakens_coat = class({})
LinkLuaModifier( "item_krakens_coat_modifier", "items/item_krakens_coat_modifier", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_krakens_coat:GetIntrinsicModifierName()
    return "item_krakens_coat_modifier"
end