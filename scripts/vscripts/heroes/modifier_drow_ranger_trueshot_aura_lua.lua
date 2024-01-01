modifier_drow_ranger_trueshot_aura_lua = class({})
--------------------------------------------------------------------------------
function modifier_drow_ranger_trueshot_aura_lua:IsHidden()
	return true
end

function modifier_drow_ranger_trueshot_aura_lua:IsDebuff()
	return false
end

--------------------------------------------------------------------------------

function modifier_drow_ranger_trueshot_aura_lua:IsAura()
    return true
end

--------------------------------------------------------------------------------

function modifier_drow_ranger_trueshot_aura_lua:GetModifierAura()
	return "modifier_drow_ranger_trueshot_aura_lua_effect"
end

--------------------------------------------------------------------------------

function modifier_drow_ranger_trueshot_aura_lua:GetAuraRadius()
	return self.radius
end

--------------------------------------------------------------------------------
function modifier_drow_ranger_trueshot_aura_lua:GetAuraSearchTeam()
	if not self:GetParent():PassivesDisabled() then
		return DOTA_UNIT_TARGET_TEAM_FRIENDLY
	end
end

--------------------------------------------------------------------------------

function modifier_drow_ranger_trueshot_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------

function modifier_drow_ranger_trueshot_aura_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_RANGED_ONLY
end

--------------------------------------------------------------------------------

function modifier_drow_ranger_trueshot_aura_lua:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_drow_ranger_trueshot_aura_lua:OnRefresh( kv )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_drow_ranger_trueshot_aura_lua:OnDestroy()

end

