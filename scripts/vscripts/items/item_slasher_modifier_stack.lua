item_slasher_modifier_stack = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_slasher_modifier_stack:IsHidden()
	return false
end

function item_slasher_modifier_stack:IsDebuff()
	return false
end

function item_slasher_modifier_stack:IsPurgable()
	return false
end

function item_slasher_modifier_stack:IsPermanent()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_slasher_modifier_stack:OnCreated( kv )
	self.stat_gain = self:GetAbility():GetSpecialValueFor( "stat_gain" )
	self.stack_count = self.stat_gain
	self:SetStackCount( self.stack_count )
end

function item_slasher_modifier_stack:OnRefresh( kv )
	self.stat_gain = self:GetAbility():GetSpecialValueFor( "stat_gain" )
	self.stack_count = self:GetStackCount()
end


--------------------------------------------------------------------------------
-- Modifier Effects
function item_slasher_modifier_stack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOOLTIP
	}

	return funcs
end

function item_slasher_modifier_stack:OnTooltip()
	return self.stack_count
end