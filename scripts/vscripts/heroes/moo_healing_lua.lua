moo_healing_lua = class({})
LinkLuaModifier( "modifier_moo_healing_lua", "heroes/modifier_moo_healing_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_moo_healing_lua_effect", "heroes/modifier_moo_healing_lua_effect", LUA_MODIFIER_MOTION_NONE )
--------------------------------------------------------------------------------
-- Passive Modifier
function moo_healing_lua:GetIntrinsicModifierName()
	return "modifier_moo_healing_lua"
end