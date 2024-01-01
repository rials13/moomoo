razor_ronels_skin_lua = class({})
LinkLuaModifier( "modifier_razor_ronels_skin_lua", "heroes/modifier_razor_ronels_skin_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_razor_ronels_skin_lua_effect", "heroes/modifier_razor_ronels_skin_lua_effect", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function razor_ronels_skin_lua:GetIntrinsicModifierName()
	return "modifier_razor_ronels_skin_lua"
end