modifier_pudge_unholy_rage_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_pudge_unholy_rage_lua:IsHidden()
	return false
end

function modifier_pudge_unholy_rage_lua:IsDebuff()
	return false
end

function modifier_pudge_unholy_rage_lua:IsStunDebuff()
	return false
end

function modifier_pudge_unholy_rage_lua:IsPurgable()
	return false
end

function modifier_pudge_unholy_rage_lua:AllowIllusionDuplicate()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_pudge_unholy_rage_lua:OnCreated( kv )
	-- references
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
    self.life_steal = self:GetAbility():GetSpecialValueFor( "life_steal" )

	if not IsServer() then return end

	-- disjoint & purge
	ProjectileManager:ProjectileDodge( self:GetParent() )
	self:GetParent():Purge( false, true, false, false, false )

	-- play effects
	self:PlayEffects()
end

function modifier_pudge_unholy_rage_lua:OnRefresh( kv )
	-- references
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
    self.life_steal = self:GetAbility():GetSpecialValueFor( "life_steal" )


	if not IsServer() then return end

	-- disjoint & purge
	ProjectileManager:ProjectileDodge( self:GetParent() )
	self:GetParent():Purge( false, true, false, false, false )
end

function modifier_pudge_unholy_rage_lua:OnRemoved()
end

function modifier_pudge_unholy_rage_lua:OnDestroy()
	if not IsServer() then return end

	-- stop effects
	local sound_cast = "Hero_Alchemist.ChemicalRage"
	StopSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_pudge_unholy_rage_lua:DeclareFunctions()
	local funcs = {
    MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	MODIFIER_PROPERTY_TOOLTIP,
    MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_pudge_unholy_rage_lua:GetModifierBaseAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_pudge_unholy_rage_lua:OnTooltip()
	return self.life_steal
end

function modifier_pudge_unholy_rage_lua:OnTakeDamage( params )
	-- logic
	if IsServer() then
		if params.attacker == self:GetParent() and ( not self:GetParent():IsIllusion() ) then -- checks that pudge is attacker and not an illusion
			if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
				return
			end
			local heal = params.damage * self.life_steal / 100
			self:GetParent():Heal( heal, self:GetAbility() )
			--------------------------------------------------------------------------------
            -- Graphics and Animations
    	    -- get resource
    	    local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"
    	    --play effects
    	    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    	    ParticleManager:ReleaseParticleIndex( effect_cast )

			print("lifesteal heals: " .. heal)
		end
	end
end


--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_pudge_unholy_rage_lua:GetHeroEffectName()
	return "particles/units/heroes/hero_alchemist/alchemist_chemical_rage_hero_effect.vpcf"
end

function modifier_pudge_unholy_rage_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_chemical_rage.vpcf"
	local sound_cast = "Hero_Alchemist.ChemicalRage"

	-- Create Particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end