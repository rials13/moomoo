item_warlock_skull_modifier_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_warlock_skull_modifier_passive:IsHidden()
	return true
end

function item_warlock_skull_modifier_passive:IsDebuff()
	return false
end

function item_warlock_skull_modifier_passive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_warlock_skull_modifier_passive:OnCreated( kv )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.strength = self:GetAbility():GetSpecialValueFor( "strength" )
end

function item_warlock_skull_modifier_passive:OnRefresh( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.strength = self:GetAbility():GetSpecialValueFor( "strength" )
end

function item_warlock_skull_modifier_passive:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_warlock_skull_modifier_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,

	}

	return funcs
end

function item_warlock_skull_modifier_passive:GetModifierBonusStats_Strength( params )
	return self.strength
end

function item_warlock_skull_modifier_passive:GetModifierPreAttack_BonusDamage( params )
	return self.damage
end
