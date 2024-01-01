item_avieoletz_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_avieoletz_modifier:IsHidden()
	return true
end

function item_avieoletz_modifier:IsDebuff()
	return false
end

function item_avieoletz_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_avieoletz_modifier:OnCreated( kv )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.all_stats = self:GetAbility():GetSpecialValueFor( "all_stats" )
	self.stats_gain_pct = self:GetAbility():GetSpecialValueFor( "stats_gain_pct" )
	self.stat_gain = self:GetAbility():GetSpecialValueFor( "stat_gain" )
end

function item_avieoletz_modifier:OnRefresh( kv )
	-- references
	
end

function item_avieoletz_modifier:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_avieoletz_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function item_avieoletz_modifier:GetModifierPreAttack_BonusDamage( params )
	return self.damage
end

function item_avieoletz_modifier:GetModifierBonusStats_Strength( params )
	return self.all_stats
end
function item_avieoletz_modifier:GetModifierBonusStats_Agility( params )
	return self.all_stats
end
function item_avieoletz_modifier:GetModifierBonusStats_Intellect( params )
	return self.all_stats
end
--------------------------------------------------------------------------------

function item_avieoletz_modifier:OnDeath( params )
	-- used shadow fiend necromastery as an example of handling death
	if IsServer() then
		self:KillLogic( params )
	end

end


function item_avieoletz_modifier:KillLogic( params )
	-- filter
	local target = params.unit
	local attacker = params.attacker
	local pass = false
	if attacker==self:GetParent() and target~=self:GetParent() and attacker:IsAlive() then
		if (not target:IsIllusion()) and (not target:IsBuilding()) then
			pass = true
		end
	end

	-- logic
	if pass then --and (not self:GetParent():PassivesDisabled()) then
		if self:RollChance( self.stats_gain_pct ) then
			self:AddStack( self.stat_gain )
			self:PlayEffects()
		end

		--self:PlayEffects( target )
	end

end

function item_avieoletz_modifier:AddStack( stat_gain )
	-- update strength
	self:GetParent():SetBaseStrength( self:GetParent():GetBaseStrength() + stat_gain )
	self:GetParent():SetBaseAgility( self:GetParent():GetBaseAgility() + stat_gain )
	self:GetParent():SetBaseIntellect( self:GetParent():GetBaseIntellect() + stat_gain )

	print("gained stats")

	-- update modifier stack count
	-- from pudge flesh heap
	local hBuff = self:GetParent():FindModifierByName( "item_avieoletz_modifier_stack" )
	if hBuff == nil then
		-- Add Modifier
		local mod = self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"item_avieoletz_modifier_stack", {}
		)
		mod.modifier = self
	else
		hBuff:SetStackCount( hBuff:GetStackCount() + stat_gain )
	end
end

--------------------------------------------------------------------------------
function item_avieoletz_modifier:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_slark/slark_essence_shift_hit_glow.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

--------------------------------------------------------------------------------
-- Helper
function item_avieoletz_modifier:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end