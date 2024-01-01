item_moo_moo_tshirt_modifier_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_moo_moo_tshirt_modifier_passive:IsHidden()
	return true
end

function item_moo_moo_tshirt_modifier_passive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function item_moo_moo_tshirt_modifier_passive:OnCreated( kv )
	-- references
	self.all_stats = self:GetAbility():GetSpecialValueFor( "all_stats" )
end

function item_moo_moo_tshirt_modifier_passive:OnRefresh( kv )
	-- references
	self:OnCreated( kv )
end

function item_moo_moo_tshirt_modifier_passive:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_moo_moo_tshirt_modifier_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}

	return funcs
end

function item_moo_moo_tshirt_modifier_passive:GetModifierBonusStats_Strength( params )
	return self.all_stats
end

function item_moo_moo_tshirt_modifier_passive:GetModifierBonusStats_Agility( params )
	return self.all_stats
end

function item_moo_moo_tshirt_modifier_passive:GetModifierBonusStats_Intellect( params )
	return self.all_stats
end