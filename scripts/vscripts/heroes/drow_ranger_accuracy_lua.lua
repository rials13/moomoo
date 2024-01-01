drow_ranger_accuracy_lua = class({})
LinkLuaModifier( "modifier_drow_ranger_accuracy_lua", "heroes/modifier_drow_ranger_accuracy_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function drow_ranger_accuracy_lua:GetIntrinsicModifierName()
	return "modifier_drow_ranger_accuracy_lua"
end