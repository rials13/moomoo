item_sadistic_axe = class({})
LinkLuaModifier( "item_sadistic_axe_modifier", "items/item_sadistic_axe_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_sadistic_axe_modifier_passive", "items/item_sadistic_axe_modifier_passive", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function item_sadistic_axe:GetIntrinsicModifierName()
	return "item_sadistic_axe_modifier_passive"
end

--------------------------------------------------------------------------------
-- Ability Start
function item_sadistic_axe:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local bDuration = self:GetSpecialValueFor("duration")

    -- unit groups
	self.hitEnemies = {}

    -- set cooldown
    self:UseResources( false, false, true ) 

	-- Add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"item_sadistic_axe_modifier", -- modifier name
		{ duration = bDuration } -- kv
	)
    -- Play effects
	self:PlayEffects()
end

function item_sadistic_axe:HasDamaged( target )
	-- search in tables
	for _,enemy in pairs(self.hitEnemies) do
		if target==enemy then return true end
	end
	return false
end

--------------------------------------------------------------------------------
function item_sadistic_axe:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_invoker/invoker_ghost_walk.vpcf"
	local sound_cast = "Hero_Invoker.GhostWalk"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end