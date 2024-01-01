--------------------------------------------------------------------------------
pudge_unholy_rage_lua = class({})
LinkLuaModifier( "modifier_pudge_unholy_rage_lua", "heroes/modifier_pudge_unholy_rage_lua", LUA_MODIFIER_MOTION_NONE )


--------------------------------------------------------------------------------
-- Ability Start
function pudge_unholy_rage_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_pudge_unholy_rage_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_Alchemist.ChemicalRage.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

