item_ballista_wc_modifier_aura_melee = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_ballista_wc_modifier_aura_melee:IsHidden()
	return false
end

function item_ballista_wc_modifier_aura_melee:IsDebuff()
	return false
end

function item_ballista_wc_modifier_aura_melee:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function item_ballista_wc_modifier_aura_melee:OnCreated( kv )
	-- references
	self.damage_pct_melee = self:GetAbility():GetSpecialValueFor( "damage_pct_melee" )
end

function item_ballista_wc_modifier_aura_melee:OnRefresh( kv )
    self.damage_pct_melee = self:GetAbility():GetSpecialValueFor( "damage_pct_melee" )
end

function item_ballista_wc_modifier_aura_melee:OnDestroy( kv ) end
--------------------------------------------------------------------------------
-- Modifier Effects
function item_ballista_wc_modifier_aura_melee:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function item_ballista_wc_modifier_aura_melee:GetModifierBaseDamageOutgoing_Percentage( params )
	--this is return the damage buff to those affected by aura
	return self.damage_pct_melee
end