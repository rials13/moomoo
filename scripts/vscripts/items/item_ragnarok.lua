item_ragnarok = class({})
LinkLuaModifier( "item_ragnarok_modifier", "items/item_ragnarok_modifier", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_ragnarok:GetIntrinsicModifierName()
    return "item_ragnarok_modifier"
end