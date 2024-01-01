item_wirts_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_wirts_modifier:IsHidden()
	return true
end

function item_wirts_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function item_wirts_modifier:OnCreated( kv )
	-- references
	self.move_speed = self:GetAbility():GetSpecialValueFor( "move_speed" )
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" )
	self.all_stats = self:GetAbility():GetSpecialValueFor( "all_stats" )
end

function item_wirts_modifier:OnRefresh( kv )
	-- references
	self:OnCreated( kv )
end

function item_wirts_modifier:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_wirts_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		--MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}

	return funcs
end

function item_wirts_modifier:GetModifierBonusStats_Strength( params )
	return self.all_stats
end

function item_wirts_modifier:GetModifierBonusStats_Agility( params )
	return self.all_stats
end

function item_wirts_modifier:GetModifierBonusStats_Intellect( params )
	return self.all_stats
end

function item_wirts_modifier:GetModifierAttackSpeedBonus_Constant( params )
	return self.attack_speed
end

function item_wirts_modifier:GetModifierMoveSpeedBonus_Special_Boots( params )
	return self.move_speed
end
