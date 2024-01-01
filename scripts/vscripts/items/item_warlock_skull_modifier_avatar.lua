item_warlock_skull_modifier_avatar = class({})
--------------------------------------------------------------------------------
-- Classifications
function item_warlock_skull_modifier_avatar:IsHidden()
	return false
end

function item_warlock_skull_modifier_avatar:IsDebuff()
	return false
end

function item_warlock_skull_modifier_avatar:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function item_warlock_skull_modifier_avatar:OnCreated( kv )
	-- references
	self.parent = self:GetParent()

	self.move_speed = self:GetAbility():GetSpecialValueFor( "move_speed" )
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" )
	self.model = "models/particle/skull.vmdl"

	-- Start effects (from sanking sandstorm)
	self:PlayEffects()

end

function item_warlock_skull_modifier_avatar:OnRefresh( kv )
	-- references
	self:OnCreated(kv)
end

function item_warlock_skull_modifier_avatar:OnDestroy( kv )
	self:StopEffects()
end


--------------------------------------------------------------------------------
-- Modifier Effects
function item_warlock_skull_modifier_avatar:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,

		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}

	return funcs
end

function item_warlock_skull_modifier_avatar:GetModifierMoveSpeedBonus_Constant()
	return self.move_speed
end
function item_warlock_skull_modifier_avatar:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed
end

function item_warlock_skull_modifier_avatar:GetModifierModelChange()
	return self.model
end

function item_warlock_skull_modifier_avatar:GetModifierModelScale()
	return 1000
end

--------------------------------------------------------------------------------
-- Status Effects
function item_warlock_skull_modifier_avatar:CheckState()
	local state = {
	[MODIFIER_STATE_MAGIC_IMMUNE ] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function item_warlock_skull_modifier_avatar:PlayEffects(  )
	-- Get Resources
	local particle_cast1 = "particles/items_fx/black_king_bar_avatar.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_sandking/sandking_sandstorm.vpcf"
	local sound_cast = "sounds/items/black_king_bar.vsnd"

	-- Create Particle
	self.effect_cast1 = ParticleManager:CreateParticle( particle_cast1, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	self.effect_cast2 = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

	--ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
	--ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( radius, radius, radius ) )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end

function item_warlock_skull_modifier_avatar:StopEffects()
	-- Stop particles
	ParticleManager:DestroyParticle( self.effect_cast1, false )
	ParticleManager:DestroyParticle( self.effect_cast2, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast1 )
	ParticleManager:ReleaseParticleIndex( self.effect_cast2 )

	-- Stop sound
	local sound_cast = "sounds/items/black_king_bar.vsnd"
	StopSoundOn( sound_cast, self:GetParent() )
end
