item_mystic_grallen_modifier_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_mystic_grallen_modifier_passive:IsHidden()
	return true
end

function item_mystic_grallen_modifier_passive:IsDebuff()
	return false
end

function item_mystic_grallen_modifier_passive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_mystic_grallen_modifier_passive:OnCreated( kv )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.intelligence = self:GetAbility():GetSpecialValueFor( "intelligence" )
	self.mana_regen = self:GetAbility():GetSpecialValueFor( "mana_regen" )
	
end

function item_mystic_grallen_modifier_passive:OnRefresh( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.intelligence = self:GetAbility():GetSpecialValueFor( "intelligence" )
	self.mana_regen = self:GetAbility():GetSpecialValueFor( "mana_regen" )
end

function item_mystic_grallen_modifier_passive:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_mystic_grallen_modifier_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE,

	}

	return funcs
end

function item_mystic_grallen_modifier_passive:GetModifierBonusStats_Intellect( params )
	return self.intelligence
end

function item_mystic_grallen_modifier_passive:GetModifierPreAttack_BonusDamage( params )
	return self.damage
end

function item_mystic_grallen_modifier_passive:GetModifierPercentageManaRegen( params )
	return self.mana_regen
end
