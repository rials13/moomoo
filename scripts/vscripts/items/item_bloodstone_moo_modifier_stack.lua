item_bloodstone_moo_modifier_stack = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_bloodstone_moo_modifier_stack:IsHidden()
	return false
end

function item_bloodstone_moo_modifier_stack:IsDebuff()
	return false
end

function item_bloodstone_moo_modifier_stack:IsPurgable()
	return false
end

function item_bloodstone_moo_modifier_stack:IsPermanent()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_bloodstone_moo_modifier_stack:OnCreated( kv )
	self.life_gain_health = self:GetAbility():GetSpecialValueFor( "life_gain_health" )
	self.stack_count = 1
	self.bonus_health = self.stack_count * self.life_gain_health
	self:SetStackCount( self.stack_count )
end

function item_bloodstone_moo_modifier_stack:OnRefresh( kv )
	self.life_gain_health = self:GetAbility():GetSpecialValueFor( "life_gain_health" )
	self.stack_count = self:GetStackCount()
	self.bonus_health = self.stack_count * self.life_gain_health
end


--------------------------------------------------------------------------------
-- Modifier Effects
function item_bloodstone_moo_modifier_stack:DeclareFunctions()
	local funcs = {
		--MODIFIER_PROPERTY_HEALTH_BONUS	,
		MODIFIER_PROPERTY_TOOLTIP
	}

	return funcs
end

--[[function item_bloodstone_moo_modifier_stack:GetModifierHealthBonus()
	return self.bonus_health
end]]

function item_bloodstone_moo_modifier_stack:OnTooltip()
	return self.bonus_health
end