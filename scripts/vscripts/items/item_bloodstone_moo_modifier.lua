item_bloodstone_moo_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_bloodstone_moo_modifier:IsHidden()
	return true
end

function item_bloodstone_moo_modifier:IsDebuff()
	return false
end

function item_bloodstone_moo_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_bloodstone_moo_modifier:OnCreated( kv )
	self.health = self:GetAbility():GetSpecialValueFor( "health" )
	self.mana = self:GetAbility():GetSpecialValueFor( "mana" )
	self.health_regen = self:GetAbility():GetSpecialValueFor( "health_regen" )
	self.mana_regen = self:GetAbility():GetSpecialValueFor( "mana_regen" )
	self.life_gain_chance = self:GetAbility():GetSpecialValueFor( "life_gain_chance" )
	self.life_gain_health = self:GetAbility():GetSpecialValueFor( "life_gain_health" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function item_bloodstone_moo_modifier:OnRefresh( kv )
	-- references
	self:OnCreated(kv)
end

function item_bloodstone_moo_modifier:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_bloodstone_moo_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE,
		
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function item_bloodstone_moo_modifier:GetModifierHealthBonus( params )
	return self.health
end

function item_bloodstone_moo_modifier:GetModifierManaBonus( params )
	return self.mana
end

function item_bloodstone_moo_modifier:GetModifierConstantHealthRegen( params )
	return self.health_regen
end

function item_bloodstone_moo_modifier:GetModifierPercentageManaRegen( params )
	return self.mana_regen
end
--------------------------------------------------------------------------------

function item_bloodstone_moo_modifier:OnDeath( params )
	-- used shadow fiend necromastery as an example of handling death
	if not IsServer() then return end
	-- filter
	local pass = false
	local target = params.unit
	local attacker = params.attacker
	if target == nil or attacker == nil then return end
	if attacker:GetTeamNumber() == target:GetTeamNumber() then return end
	if attacker:IsAlive() ~= true then return end
	if target:IsIllusion() or target:IsBuilding() then return end
	
	-- from flesh heap
	local vToCaster = self:GetParent():GetOrigin() - target:GetOrigin()
	local flDistance = vToCaster:Length2D()
	if attacker == self:GetParent() or self.radius >= flDistance then
		pass = true
		-- logic
		if pass then --and (not self:GetParent():PassivesDisabled()) then
			if self:RollChance( self.life_gain_chance ) then
				self:AddStack( self.life_gain_health )
			--self:PlayEffects()
			end
		end
	end

end

function item_bloodstone_moo_modifier:AddStack( health_gain )
	-- update  health
	--self:GetParent():SetBaseMaxHealth( self:GetParent():GetBaseMaxHealth() + health_gain )
	print("gained life from bloodstone")

	-- update health
	-- from pudge flesh heap
	local hBuff = self:GetParent():FindModifierByName( "item_bloodstone_moo_modifier_stack" )
	if hBuff == nil then
		-- Add Modifier
		local mod = self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"item_bloodstone_moo_modifier_stack", {}
		)
		mod.modifier = self
	else
		hBuff:SetStackCount( hBuff:GetStackCount() + 1 )
	end
	-- set max health
	self:GetParent():SetMaxHealth( self:GetParent():GetMaxHealth() + health_gain )

	-- overhead event
	SendOverheadEventMessage(
		nil,
		OVERHEAD_ALERT_HEAL ,
		self:GetParent(),
		health_gain,
		nil
	)
end

--------------------------------------------------------------------------------
function item_bloodstone_moo_modifier:PlayEffects()
	--local particle_cast = "particles/units/heroes/hero_slark/slark_essence_shift_hit_glow.vpcf"

	--local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	--ParticleManager:ReleaseParticleIndex( effect_cast )
end

--------------------------------------------------------------------------------
-- Helper
function item_bloodstone_moo_modifier:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end