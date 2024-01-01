drow_ranger_death_shot_lua = class({})
LinkLuaModifier( "modifier_drow_ranger_empowerment_lua", "heroes/modifier_drow_ranger_empowerment_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function drow_ranger_death_shot_lua:GetIntrinsicModifierName()
	return "modifier_drow_ranger_empowerment_lua"
end