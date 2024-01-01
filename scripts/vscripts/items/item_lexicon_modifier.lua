item_lexicon_modifier = class({})
--------------------------------------------------------------------------------
function item_lexicon_modifier:IsHidden()
	return true
end

function item_lexicon_modifier:IsDebuff()
	return false
end

--------------------------------------------------------------------------------

function item_lexicon_modifier:OnCreated( kv )
    self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" )
    self.armor = self:GetAbility():GetSpecialValueFor( "armor" )
end

function item_lexicon_modifier:OnRefresh( kv )
    self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" )
    self.armor = self:GetAbility():GetSpecialValueFor( "armor" )
end

function item_lexicon_modifier:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_lexicon_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function item_lexicon_modifier:GetModifierAttackSpeedBonus_Constant()
    return self.attack_speed
end

function item_lexicon_modifier:GetModifierPhysicalArmorBonus()
    return self.armor
end