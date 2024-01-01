lion_unlock_potential_lua = class({})
LinkLuaModifier( "modifier_lion_unlock_potential_lua", "heroes/modifier_lion_unlock_potential_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lion_unlock_potential_buff_lua", "heroes/modifier_lion_unlock_potential_buff_lua", LUA_MODIFIER_MOTION_NONE )


function lion_unlock_potential_lua:GetIntrinsicModifierName()
	return "modifier_lion_unlock_potential_lua"
end

--------------------------------------------------------------------------------
-- Ability Start
function lion_unlock_potential_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

    -- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_lion_unlock_potential_buff_lua", -- modifier name
		{} -- kv
	)

    -- play effects
	self:PlayEffects( target )
end

--------------------------------------------------------------------------------
function lion_unlock_potential_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_cast.vpcf"
	local sound_cast = "Hero_OgreMagi.Bloodlust.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end