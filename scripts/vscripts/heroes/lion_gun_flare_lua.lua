lion_gun_flare_lua = class({})
LinkLuaModifier( "modifier_lion_gun_flare_lua", "heroes/modifier_lion_gun_flare_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lion_gun_flare_lua_thinker", "heroes/modifier_lion_gun_flare_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function lion_gun_flare_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function lion_gun_flare_lua:OnAbilityPhaseStart()
	local point = self:GetCursorPosition()

	self:PlayEffects( point )

	return true -- if success
end

function lion_gun_flare_lua:OnAbilityPhaseInterrupted()
	self:StopEffects()
end

--------------------------------------------------------------------------------
-- Ability Start
function lion_gun_flare_lua:OnSpellStart()
	self:StopEffects()

	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_lion_gun_flare_lua_thinker", -- modifier name
		{}, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
end

--------------------------------------------------------------------------------
function lion_gun_flare_lua:PlayEffects( point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/heroes_underlord/underlord_firestorm_pre.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.Firestorm.Start"

	-- get data
	local radius = self:GetSpecialValueFor( "radius" )

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticleForTeam( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, point )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 2, 2, 2 ) )

	-- Create Sound
	EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
end

function lion_gun_flare_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, true )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end