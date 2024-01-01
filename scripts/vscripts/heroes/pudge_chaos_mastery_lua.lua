pudge_chaos_mastery_lua = class({})
LinkLuaModifier( "modifier_pudge_chaos_mastery_lua", "heroes/modifier_pudge_chaos_mastery_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_pudge_chaos_mastery_lua_stack", "heroes/modifier_pudge_chaos_mastery_lua_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function pudge_chaos_mastery_lua:GetIntrinsicModifierName()
	return "modifier_pudge_chaos_mastery_lua"
end

--------------------------------------------------------------------------------