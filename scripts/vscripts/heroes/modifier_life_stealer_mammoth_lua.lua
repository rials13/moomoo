modifier_life_stealer_mammoth_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_life_stealer_mammoth_lua:IsHidden()
	return true
end

function modifier_life_stealer_mammoth_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_life_stealer_mammoth_lua:OnCreated( kv )
	self.bonus_strength = self:GetAbility():GetSpecialValueFor( "bonus_strength" )
	self.model_scale_inc = self:GetAbility():GetSpecialValueFor( "model_scale_inc" )
end

function modifier_life_stealer_mammoth_lua:OnRefresh( kv )
	self.bonus_strength = self:GetAbility():GetSpecialValueFor( "bonus_strength" )
	self.model_scale_inc = self:GetAbility():GetSpecialValueFor( "model_scale_inc" )
end

function modifier_life_stealer_mammoth_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_life_stealer_mammoth_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MODEL_SCALE
	}

	return funcs
end

function modifier_life_stealer_mammoth_lua:GetModifierBonusStats_Strength()
	return self.bonus_strength
end

function modifier_life_stealer_mammoth_lua:GetModifierModelScale()
	return self.model_scale_inc
end
