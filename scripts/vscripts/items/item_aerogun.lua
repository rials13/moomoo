item_aerogun = class({})
LinkLuaModifier( "item_aerogun_modifier", "items/item_aerogun_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_aerogun_modifier_debuff", "items/item_aerogun_modifier_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function item_aerogun:GetIntrinsicModifierName()
	return "item_aerogun_modifier"
end

--------------------------------------------------------------------------------