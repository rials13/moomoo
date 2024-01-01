modifier_drow_ranger_trueshot_aura_lua_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_drow_ranger_trueshot_aura_lua_effect:IsHidden()
	return false
end

function modifier_drow_ranger_trueshot_aura_lua_effect:IsDebuff()
	return false
end

function modifier_drow_ranger_trueshot_aura_lua_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_drow_ranger_trueshot_aura_lua_effect:OnCreated( kv )

	self.ranged_dmg_pct = self:GetAbility():GetSpecialValueFor( "ranged_dmg_pct" )
end

function modifier_drow_ranger_trueshot_aura_lua_effect:OnRefresh( kv )
	-- references
	self.ranged_dmg_pct = self:GetAbility():GetSpecialValueFor( "ranged_dmg_pct" )
end

function modifier_drow_ranger_trueshot_aura_lua_effect:OnRemoved()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_drow_ranger_trueshot_aura_lua_effect:DeclareFunctions()
	local funcs = {
		-- chosing base damage as the wiki says damage percent items in game affect base damage 
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE
	}

	return funcs
end

function modifier_drow_ranger_trueshot_aura_lua_effect:GetModifierBaseDamageOutgoing_Percentage()
	return self.ranged_dmg_pct
end

--------------------------------------------------------------------------------
-- Graphics & Animations