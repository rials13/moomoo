item_helm_of_hador = class({})
LinkLuaModifier( "item_helm_of_hador_modifier", "items/item_helm_of_hador_modifier", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function item_helm_of_hador:GetIntrinsicModifierName()
	return "item_helm_of_hador_modifier"
end
