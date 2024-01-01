item_glory_axe_modifier_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_glory_axe_modifier_passive:IsHidden()
	return true
end

function item_glory_axe_modifier_passive:IsDebuff()
	return false
end

function item_glory_axe_modifier_passive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_glory_axe_modifier_passive:OnCreated( kv )
	self.agility = self:GetAbility():GetSpecialValueFor( "agility" )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_glory_axe_modifier_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}

	return funcs
end

function item_glory_axe_modifier_passive:GetModifierBonusStats_Agility( params )
	return self.agility
end