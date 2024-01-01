item_ballista_wc_modifier_aura_ranged = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_ballista_wc_modifier_aura_ranged:IsHidden()
	return false
end

function item_ballista_wc_modifier_aura_ranged:IsDebuff()
	return false
end

function item_ballista_wc_modifier_aura_ranged:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function item_ballista_wc_modifier_aura_ranged:OnCreated( kv )
	-- references
	self.damage_pct_range = self:GetAbility():GetSpecialValueFor( "damage_pct_range" )
end

function item_ballista_wc_modifier_aura_ranged:OnRefresh( kv )
    self.damage_pct_range = self:GetAbility():GetSpecialValueFor( "damage_pct_range" )
end

function item_ballista_wc_modifier_aura_ranged:OnDestroy( kv ) end
--------------------------------------------------------------------------------
-- Modifier Effects
function item_ballista_wc_modifier_aura_ranged:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function item_ballista_wc_modifier_aura_ranged:GetModifierBaseDamageOutgoing_Percentage( params )
	--this is return the damage buff to those affected by aura
	return self.damage_pct_range
end