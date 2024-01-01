modifier_razor_ronels_skin_lua_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_razor_ronels_skin_lua_effect:IsHidden()
	return false
end

function modifier_razor_ronels_skin_lua_effect:IsDebuff()
	return true
end

function modifier_razor_ronels_skin_lua_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_razor_ronels_skin_lua_effect:OnCreated( kv )

	self.magic_reduction = self:GetAbility():GetSpecialValueFor( "magic_reduction" )
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
end

function modifier_razor_ronels_skin_lua_effect:OnRefresh( kv )
	-- references
	self.magic_reduction = self:GetAbility():GetSpecialValueFor( "magic_reduction" )
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
end

function modifier_razor_ronels_skin_lua_effect:OnRemoved()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_razor_ronels_skin_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}

	return funcs
end

function modifier_razor_ronels_skin_lua_effect:GetModifierMagicDamageOutgoing_Percentage()
	return self.magic_reduction * -1
end

function modifier_razor_ronels_skin_lua_effect:GetModifierPhysicalArmorBonus()
	return self.armor_reduction * -1
end


--------------------------------------------------------------------------------
-- Graphics & Animations