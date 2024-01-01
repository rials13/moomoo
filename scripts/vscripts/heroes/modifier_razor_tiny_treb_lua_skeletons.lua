modifier_razor_tiny_treb_lua_skeletons = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_razor_tiny_treb_lua_skeletons:IsHidden()
	return true
end

function modifier_razor_tiny_treb_lua_skeletons:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function modifier_razor_tiny_treb_lua_skeletons:OnCreated( kv )
	self.skeleton_life_add = self:GetAbility():GetSpecialValueFor( "skeleton_life_add" )
    self.skeleton_damage = self:GetAbility():GetSpecialValueFor( "skeleton_damage" )
    self.skeleton_armor = self:GetAbility():GetSpecialValueFor( "skeleton_armor" )
end

function modifier_razor_tiny_treb_lua_skeletons:OnRefresh( kv )
end

function modifier_razor_tiny_treb_lua_skeletons:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_razor_tiny_treb_lua_skeletons:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}

	return funcs
end

function modifier_razor_tiny_treb_lua_skeletons:GetModifierExtraHealthBonus()
    return self.skeleton_life_add
end

function modifier_razor_tiny_treb_lua_skeletons:GetModifierBaseAttack_BonusDamage()
    return self.skeleton_damage
end

function modifier_razor_tiny_treb_lua_skeletons:GetModifierPhysicalArmorBonus()
    return self.skeleton_armor
end