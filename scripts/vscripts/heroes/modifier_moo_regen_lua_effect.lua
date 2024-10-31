--------------------------------------------------------------------------------
modifier_moo_regen_lua_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_moo_regen_lua_effect:IsHidden()
	return false
end

function modifier_moo_regen_lua_effect:IsDebuff()
	return false
end

function modifier_moo_regen_lua_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_moo_regen_lua_effect:OnCreated( kv )
	-- references
	self.hp_regen = self:GetAbility():GetSpecialValueFor( "hp_regen" )

	if not IsServer() then return end
end

function modifier_moo_regen_lua_effect:OnRefresh( kv )
	-- references
	self.hp_regen = self:GetAbility():GetSpecialValueFor( "hp_regen" )
end

function modifier_moo_regen_lua_effect:OnRemoved()
end

function modifier_moo_regen_lua_effect:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_moo_regen_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}

	return funcs
end

function modifier_moo_regen_lua_effect:GetModifierConstantHealthRegen()
	return self.hp_regen
end