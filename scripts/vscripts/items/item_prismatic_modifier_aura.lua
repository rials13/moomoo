item_prismatic_modifier_aura = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_prismatic_modifier_aura:IsHidden()
	return false
end

function item_prismatic_modifier_aura:IsDebuff()
	return false
end

function item_prismatic_modifier_aura:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function item_prismatic_modifier_aura:OnCreated( kv )
	-- references
	self.health_regen = self:GetAbility():GetSpecialValueFor( "health_regen" )
end

function item_prismatic_modifier_aura:OnRefresh( kv )
    self.health_regen = self:GetAbility():GetSpecialValueFor( "health_regen" )
end

function item_prismatic_modifier_aura:OnDestroy( kv ) end
--------------------------------------------------------------------------------
-- Modifier Effects
function item_prismatic_modifier_aura:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
	return funcs
end

function item_prismatic_modifier_aura:GetModifierConstantHealthRegen( params )
	return self.health_regen
end