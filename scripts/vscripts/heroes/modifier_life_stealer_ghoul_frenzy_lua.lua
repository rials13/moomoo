modifier_life_stealer_ghoul_frenzy_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_life_stealer_ghoul_frenzy_lua:IsHidden()
	return true
end

function modifier_life_stealer_ghoul_frenzy_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_life_stealer_ghoul_frenzy_lua:OnCreated( kv )
    self.bonus_movespeed_percent = self:GetAbility():GetSpecialValueFor( "bonus_movespeed_percent" )
    self.bonus_attackspeed_percent = self:GetAbility():GetSpecialValueFor( "bonus_attackspeed_percent" )

end

function modifier_life_stealer_ghoul_frenzy_lua:OnRefresh( kv )
    self:OnCreated( kv )
end

function modifier_life_stealer_ghoul_frenzy_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_life_stealer_ghoul_frenzy_lua:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_life_stealer_ghoul_frenzy_lua:GetModifierMoveSpeedBonus_Percentage()
   return self.bonus_movespeed_percent
end

function modifier_life_stealer_ghoul_frenzy_lua:GetModifierAttackSpeedBonus_Constant()
    return self.bonus_attackspeed_percent
end

--------------------------------------------------------------------------------
-- Graphics and Animations