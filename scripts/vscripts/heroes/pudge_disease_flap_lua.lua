--------------------------------------------------------------------------------
pudge_disease_flap_lua = class({})
LinkLuaModifier( "modifier_pudge_disease_flap_lua", "heroes/modifier_pudge_disease_flap_lua", LUA_MODIFIER_MOTION_NONE )


--------------------------------------------------------------------------------
-- Ability Start
function pudge_disease_flap_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_pudge_disease_flap_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_Pudge.Dismember.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end