razor_tiny_treb_lua = class({})
LinkLuaModifier( "modifier_razor_tiny_treb_lua", "heroes/modifier_razor_tiny_treb_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_summon_timer", LUA_MODIFIER_MOTION_NONE ) -- in main vscript folder
LinkLuaModifier( "modifier_razor_tiny_treb_lua_skeletons", "heroes/modifier_razor_tiny_treb_lua_skeletons", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function razor_tiny_treb_lua:GetIntrinsicModifierName()
	return "modifier_razor_tiny_treb_lua"
end