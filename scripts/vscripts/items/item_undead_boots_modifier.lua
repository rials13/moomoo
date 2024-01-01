item_undead_boots_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_undead_boots_modifier:IsHidden()
	return true
end

function item_undead_boots_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function item_undead_boots_modifier:OnCreated( kv )
	-- references
	self.move_speed = self:GetAbility():GetSpecialValueFor( "move_speed" )
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
end

function item_undead_boots_modifier:OnRefresh( kv )
	-- references
	self:OnCreated( kv )
end

function item_undead_boots_modifier:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_undead_boots_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		--MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}

	return funcs
end

function item_undead_boots_modifier:GetModifierPreAttack_BonusDamage( params )
	return self.damage
end

function item_undead_boots_modifier:GetModifierAttackSpeedBonus_Constant( params )
	return self.attack_speed
end

function item_undead_boots_modifier:GetModifierMoveSpeedBonus_Special_Boots( params )
	return self.move_speed
end
