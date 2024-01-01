razor_troys_strength_lua = class({})
LinkLuaModifier( "modifier_razor_troys_strength_lua", "heroes/modifier_razor_troys_strength_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function razor_troys_strength_lua:GetIntrinsicModifierName()
	return "modifier_razor_troys_strength_lua"
end