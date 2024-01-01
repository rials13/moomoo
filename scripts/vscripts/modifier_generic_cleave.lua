modifier_generic_cleave = class({})

--------------------------------------------------------------------------------

function modifier_generic_cleave:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_generic_cleave:OnCreated( kv )
	self.cleave_attack_pct = self:GetAbility():GetSpecialValueFor( "cleave_attack_pct" )
	self.cleave_start_radius = self:GetAbility():GetSpecialValueFor( "cleave_start_radius" )
    self.cleave_end_radius = self:GetAbility():GetSpecialValueFor( "cleave_end_radius" )
    self.cleave_distance = self:GetAbility():GetSpecialValueFor( "cleave_distance" )
end

--------------------------------------------------------------------------------

function modifier_generic_cleave:OnRefresh( kv )
	self.cleave_attack_pct = self:GetAbility():GetSpecialValueFor( "cleave_attack_pct" )
	self.cleave_start_radius = self:GetAbility():GetSpecialValueFor( "cleave_start_radius" )
    self.cleave_end_radius = self:GetAbility():GetSpecialValueFor( "cleave_end_radius" )
    self.cleave_distance = self:GetAbility():GetSpecialValueFor( "cleave_distance" )
end

--------------------------------------------------------------------------------

function modifier_generic_cleave:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_generic_cleave:OnAttackLanded( params )
	if IsServer() then
		if params.attacker == self:GetParent() and ( not self:GetParent():IsIllusion() ) then
			if self:GetParent():PassivesDisabled() then
				return 0
			end

			local target = params.target
			if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
				local cleaveDamage = ( self.cleave_damage * params.damage ) / 100.0
				DoCleaveAttack( self:GetParent(), target, self:GetAbility(), cleaveDamage, self.cleave_start_radius, self.cleave_end_radius, self.cleave_distance, "particles/items_fx/battlefury_cleave.vpcf" )
			end
		end
	end
	
	return 0
end