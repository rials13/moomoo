pudge_corrosive_sting_lua = class({})
LinkLuaModifier( "modifier_pudge_corrosive_sting_lua", "heroes/modifier_pudge_corrosive_sting_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_pudge_corrosive_sting_lua_debuff", "heroes/modifier_pudge_corrosive_sting_lua_debuff", LUA_MODIFIER_MOTION_NONE )


--------------------------------------------------------------------------------
-- Init Abilities
function pudge_corrosive_sting_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_poison_debuff.vpcf", context )
end

--------------------------------------------------------------------------------
-- Passive Modifier
function pudge_corrosive_sting_lua:GetIntrinsicModifierName()
	return "modifier_pudge_corrosive_sting_lua"
end