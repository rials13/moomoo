drow_ranger_trueshot_aura_lua = class({})
LinkLuaModifier( "modifier_drow_ranger_trueshot_aura_lua", "heroes/modifier_drow_ranger_trueshot_aura_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_trueshot_aura_lua_effect", "heroes/modifier_drow_ranger_trueshot_aura_lua_effect", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function drow_ranger_trueshot_aura_lua:GetIntrinsicModifierName()
	return "modifier_drow_ranger_trueshot_aura_lua"
end