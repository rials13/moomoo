magroth_immunity_modifier_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function magroth_immunity_modifier_effect:IsHidden()
	return false
end

function magroth_immunity_modifier_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function magroth_immunity_modifier_effect:OnCreated( kv )
    --self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	--self.armor = self:GetAbility():GetSpecialValueFor( "armor" )
    self.damage_percent = self:GetAbility():GetSpecialValueFor( "damage_percent" )

    if IsServer() then
        self:PlayEffects()
    end
end

function magroth_immunity_modifier_effect:OnRefresh( kv )
    --self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	--self.armor = self:GetAbility():GetSpecialValueFor( "armor" )
    --self.damage_percent = self:GetAbility():GetSpecialValueFor( "damage_percent" )
end

function magroth_immunity_modifier_effect:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function magroth_immunity_modifier_effect:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function magroth_immunity_modifier_effect:GetAbsoluteNoDamagePhysical()
   return 1
end

function magroth_immunity_modifier_effect:GetModifierDamageOutgoing_Percentage()
    return self.damage_percent
end

--------------------------------------------------------------------------------
-- Graphics and Animations
function magroth_immunity_modifier_effect:PlayEffects()
	local sound_cast = "Hero_Omniknight.GuardianAngel"
	EmitSoundOn( sound_cast, self:GetParent() )

	--local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf"
	if self:GetParent()==self:GetCaster() then
		particle_cast = "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_omni.vpcf"
	end

	-- create particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	--local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		5,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)

	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
end