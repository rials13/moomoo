item_ragnarok_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_ragnarok_modifier:IsHidden()
	return true
end

function item_ragnarok_modifier:IsDebuff()
	return false
end

function item_ragnarok_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_ragnarok_modifier:OnCreated( kv )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.health_regen = self:GetAbility():GetSpecialValueFor( "health_regen" )
	self.mana_regen = self:GetAbility():GetSpecialValueFor( "mana_regen" )
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" )
	-- for bonus damage
	self.bonus_damage_chance = self:GetAbility():GetSpecialValueFor( "bonus_damage_chance" )
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	-- for cleave
	self.cleave_attack_pct = self:GetAbility():GetSpecialValueFor( "cleave_attack_pct" )
	self.cleave_start_radius = self:GetAbility():GetSpecialValueFor( "cleave_start_radius" )
    self.cleave_end_radius = self:GetAbility():GetSpecialValueFor( "cleave_end_radius" )
    self.cleave_distance = self:GetAbility():GetSpecialValueFor( "cleave_distance" )
end

function item_ragnarok_modifier:OnRefresh( kv )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.health_regen = self:GetAbility():GetSpecialValueFor( "health_regen" )
	self.mana_regen = self:GetAbility():GetSpecialValueFor( "mana_regen" )
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" )
	-- for bonus damage
	self.bonus_damage_chance = self:GetAbility():GetSpecialValueFor( "bonus_damage_chance" )
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	-- for cleave
	self.cleave_attack_pct = self:GetAbility():GetSpecialValueFor( "cleave_attack_pct" )
	self.cleave_start_radius = self:GetAbility():GetSpecialValueFor( "cleave_start_radius" )
    self.cleave_end_radius = self:GetAbility():GetSpecialValueFor( "cleave_end_radius" )
    self.cleave_distance = self:GetAbility():GetSpecialValueFor( "cleave_distance" )
end

function item_ragnarok_modifier:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_ragnarok_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE,

		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

function item_ragnarok_modifier:GetModifierPreAttack_BonusDamage( params )
	return self.damage
end

function item_ragnarok_modifier:GetModifierAttackSpeedBonus_Constant( params )
	return self.attack_speed
end

function item_ragnarok_modifier:GetModifierConstantHealthRegen( params )
	return self.health_regen
end

function item_ragnarok_modifier:GetModifierPercentageManaRegen( params )
	return self.mana_regen
end
--------------------------------------------------------------------------------

function item_ragnarok_modifier:OnAttackLanded( params )
	if IsServer() then
		if params.attacker == self:GetParent() and ( not self:GetParent():IsIllusion() ) then
			if params.attacker:IsRangedAttacker() then return end 
			if self:GetParent():PassivesDisabled() then
				return 0
			end

			local target = params.target
			if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
				local cleaveDamage = ( self.cleave_attack_pct * params.damage ) / 100.0
				DoCleaveAttack( self:GetParent(), target, self:GetAbility(), cleaveDamage, self.cleave_start_radius, self.cleave_end_radius, self.cleave_distance, "particles/items_fx/battlefury_cleave.vpcf" )
				print("cleave damage:",cleaveDamage)
			end
		end
	end
	
	return 0
end

function item_ragnarok_modifier:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		-- fail if target is invalid
		if params.target:IsBuilding() or params.target:IsOther() then
			return 0
		end

		-- fail if status is invalid
		if self:GetParent():IsIllusion() or self:GetParent():PassivesDisabled() then
			return 0
		end

		-- roll chance to proc strength
		local roll = RandomInt(1,100)
		if roll <= self.bonus_damage_chance then
			local bonusDamage = self.bonus_damage
			print("Ragnarok bonus damage proc: " .. bonusDamage)
			return bonusDamage
		end
		
		return 0
	end
end