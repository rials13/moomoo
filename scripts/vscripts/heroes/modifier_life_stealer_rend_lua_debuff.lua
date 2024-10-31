modifier_life_stealer_rend_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_life_stealer_rend_lua_debuff:IsHidden()
	return false
end

function modifier_life_stealer_rend_lua_debuff:IsDebuff()
	return true
end

function modifier_life_stealer_rend_lua_debuff:IsStunDebuff()
	return false
end

function modifier_life_stealer_rend_lua_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_life_stealer_rend_lua_debuff:OnCreated( kv )
    self.armor_reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
    self.armor_reduction_radius = self:GetAbility():GetSpecialValueFor( "armor_reduction_radius" )
    
    if not IsServer() then return end

    -- Play effects
	self:PlayEffects()

end

function modifier_life_stealer_rend_lua_debuff:OnRefresh( kv )
    self:OnCreated( kv )
end

function modifier_life_stealer_rend_lua_debuff:OnRemoved()
end

function modifier_life_stealer_rend_lua_debuff:OnDestroy()
    
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_life_stealer_rend_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_life_stealer_rend_lua_debuff:GetModifierPhysicalArmorBonus( params )
    return self.armor_reduction * -1
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_life_stealer_rend_lua_debuff:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_viper/viper_nethertoxin_proj_launch_embers.vpcf"
	local sound_cast = "hero_viper.CorrosiveSkin"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	--ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.armor_reduction_radius, 1, 1 ) )

	-- -- buff particle
	-- self:AddParticle(
	-- 	effect_cast,
	-- 	false, -- bDestroyImmediately
	-- 	false, -- bStatusEffect
	-- 	-1, -- iPriority
	-- 	false, -- bHeroEffect
	-- 	false -- bOverheadEffect
	-- )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end