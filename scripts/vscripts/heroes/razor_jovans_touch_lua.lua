razor_jovans_touch_lua = class({})
LinkLuaModifier( "modifier_razor_jovans_touch_lua", "heroes/modifier_razor_jovans_touch_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_razor_jovans_touch_lua_debuff", "heroes/modifier_razor_jovans_touch_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function razor_jovans_touch_lua:GetIntrinsicModifierName()
	return "modifier_razor_jovans_touch_lua"
end