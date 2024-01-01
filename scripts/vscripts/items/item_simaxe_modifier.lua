item_simaxe_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_simaxe_modifier:IsHidden()
	return true
end

function item_simaxe_modifier:IsDebuff()
	return false
end

function item_simaxe_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_simaxe_modifier:OnCreated( kv )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" )
	-- for cleave
	self.cleave_attack_pct = self:GetAbility():GetSpecialValueFor( "cleave_attack_pct" )
	self.cleave_start_radius = self:GetAbility():GetSpecialValueFor( "cleave_start_radius" )
    self.cleave_end_radius = self:GetAbility():GetSpecialValueFor( "cleave_end_radius" )
    self.cleave_distance = self:GetAbility():GetSpecialValueFor( "cleave_distance" )
end

function item_simaxe_modifier:OnRefresh( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" )
	-- for cleave
	self.cleave_attack_pct = self:GetAbility():GetSpecialValueFor( "cleave_attack_pct" )
	self.cleave_start_radius = self:GetAbility():GetSpecialValueFor( "cleave_start_radius" )
    self.cleave_end_radius = self:GetAbility():GetSpecialValueFor( "cleave_end_radius" )
    self.cleave_distance = self:GetAbility():GetSpecialValueFor( "cleave_distance" )
end

function item_simaxe_modifier:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_simaxe_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED,	
	}

	return funcs
end

function item_simaxe_modifier:GetModifierPreAttack_BonusDamage( params )
	return self.damage
end

function item_simaxe_modifier:GetModifierAttackSpeedBonus_Constant( params )
	return self.attack_speed
end
--------------------------------------------------------------------------------

function item_simaxe_modifier:OnAttackLanded( params )
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