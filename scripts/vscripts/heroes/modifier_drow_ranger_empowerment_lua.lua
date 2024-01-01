modifier_drow_ranger_empowerment_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_drow_ranger_empowerment_lua:IsHidden()
	return true
end

function modifier_drow_ranger_empowerment_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_drow_ranger_empowerment_lua:OnCreated( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.agi_mult = self:GetAbility():GetSpecialValueFor( "agi_mult" )
end

function modifier_drow_ranger_empowerment_lua:OnRefresh( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.agi_mult = self:GetAbility():GetSpecialValueFor( "agi_mult" )
end

function modifier_drow_ranger_empowerment_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_drow_ranger_empowerment_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

function modifier_drow_ranger_empowerment_lua:GetModifierPreAttack_BonusDamage( params )
	self.damage = self.agi_mult * self:GetParent():GetAgility()
    return self.damage
end

function modifier_drow_ranger_empowerment_lua:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		-- fail if target is invalid
		if params.target:IsBuilding() or params.target:IsOther() then
			return 0
		end

		-- fail if status is invalid
		if self:GetParent():IsIllusion() or self:GetParent():PassivesDisabled() then
			return 0
		end

		-- roll chance to proc
		local roll = RandomInt(1,100)
		if roll <= self.crit_chance then
			local bonusDamage = self.damage
			print("Agi bonus damage: " .. bonusDamage)
			return bonusDamage
		end
		
		return 0
	end
end