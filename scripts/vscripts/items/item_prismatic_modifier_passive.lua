item_prismatic_modifier_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_prismatic_modifier_passive:IsHidden()
	return true
end

function item_prismatic_modifier_passive:IsDebuff()
	return false
end

function item_prismatic_modifier_passive:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Aura
function item_prismatic_modifier_passive:IsAura()
	return true
end

function item_prismatic_modifier_passive:GetModifierAura()
	return "item_prismatic_modifier_aura"
end

function item_prismatic_modifier_passive:GetAuraRadius()
	return self.radius
end

function item_prismatic_modifier_passive:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function item_prismatic_modifier_passive:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function item_prismatic_modifier_passive:GetAuraSearchFlags()
    return 0
end

function item_prismatic_modifier_passive:GetAuraDuration()
	return 0.5 -- stickiness: default 0.5
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_prismatic_modifier_passive:OnCreated( kv )
	self.strength = self:GetAbility():GetSpecialValueFor( "strength" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function item_prismatic_modifier_passive:OnRefresh( kv )
	-- references
	self.strength = self:GetAbility():GetSpecialValueFor( "strength" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function item_prismatic_modifier_passive:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_prismatic_modifier_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,

	}

	return funcs
end

function item_prismatic_modifier_passive:GetModifierBonusStats_Strength( params )
	return self.strength
end
