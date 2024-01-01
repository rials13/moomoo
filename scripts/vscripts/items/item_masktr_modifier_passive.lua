item_masktr_modifier_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_masktr_modifier_passive:IsHidden()
	return true
end

function item_masktr_modifier_passive:IsDebuff()
	return false
end

function item_masktr_modifier_passive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_masktr_modifier_passive:OnCreated( kv )
	self.all_stats = self:GetAbility():GetSpecialValueFor( "all_stats" )
	self.lifesteal_pct = self:GetAbility():GetSpecialValueFor( "lifesteal_pct" )
end

function item_masktr_modifier_passive:OnRefresh( kv )
	-- references
	self.all_stats = self:GetAbility():GetSpecialValueFor( "all_stats" )
	self.lifesteal_pct = self:GetAbility():GetSpecialValueFor( "lifesteal_pct" )
end

function item_masktr_modifier_passive:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_masktr_modifier_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_EVENT_ON_TAKEDAMAGE,

	}

	return funcs
end

function item_masktr_modifier_passive:GetModifierBonusStats_Strength( params )
	return self.all_stats
end

function item_masktr_modifier_passive:GetModifierBonusStats_Agility( params )
	return self.all_stats
end

function item_masktr_modifier_passive:GetModifierBonusStats_Intellect( params )
	return self.all_stats
end

function item_masktr_modifier_passive:OnTakeDamage( params )
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end -- if the attacker inst itself
	if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
		
	local heal = params.damage * self.lifesteal_pct / 100
	self:GetParent():Heal( heal, self:GetAbility() )
	self:PlayEffects( self:GetParent() )
	print("mask tho'roth lifesteal heals: " .. heal)
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function item_masktr_modifier_passive:PlayEffects( target )
	-- get resource
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"
	--local sound_cast = "Hero_ChaosKnight.ChaosStrike"

	-- play effects
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- play sound
	--EmitSoundOn( sound_cast, self:GetParent() )
end