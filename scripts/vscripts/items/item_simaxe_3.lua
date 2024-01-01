item_simaxe_3 = class({})
LinkLuaModifier( "item_simaxe_modifier", "items/item_simaxe_modifier", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_simaxe_3:GetIntrinsicModifierName()
    return "item_simaxe_modifier"
end