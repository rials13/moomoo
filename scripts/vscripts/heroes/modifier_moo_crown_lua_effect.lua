--------------------------------------------------------------------------------
modifier_moo_crown_lua_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_moo_crown_lua_effect:IsHidden()
	return false
end

function modifier_moo_crown_lua_effect:IsDebuff()
	return false
end

function modifier_moo_crown_lua_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_moo_crown_lua_effect:OnCreated( kv )
	-- references
	self.bonus_armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )

	if not IsServer() then return end
end

function modifier_moo_crown_lua_effect:OnRefresh( kv )
	-- references
	self.bonus_armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )
end

function modifier_moo_crown_lua_effect:OnRemoved()
end

function modifier_moo_crown_lua_effect:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_moo_crown_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_moo_crown_lua_effect:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end