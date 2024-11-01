item_sefer_buckler = class({})
LinkLuaModifier( "item_sefer_buckler_modifier", "items/item_sefer_buckler_modifier", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_sefer_buckler:GetIntrinsicModifierName()
    return "item_sefer_buckler_modifier"
end