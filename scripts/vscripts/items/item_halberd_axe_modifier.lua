item_halberd_axe_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_halberd_axe_modifier:IsHidden()
	return true
end

function item_halberd_axe_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_halberd_axe_modifier:OnCreated( kv )
	self.all_stats = self:GetAbility():GetSpecialValueFor( "all_stats" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.bonus_damage_chance = self:GetAbility():GetSpecialValueFor( "bonus_damage_chance" )
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_halberd_axe_modifier:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
	}

	return funcs
end

function item_halberd_axe_modifier:GetModifierBonusStats_Strength( params )
	return self.all_stats
end

function item_halberd_axe_modifier:GetModifierBonusStats_Agility( params )
	return self.all_stats
end

function item_halberd_axe_modifier:GetModifierBonusStats_Intellect( params )
	return self.all_stats
end

function item_halberd_axe_modifier:GetModifierPreAttack_BonusDamage( params )
	return self.damage
end

function item_halberd_axe_modifier:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		-- fail if target is invalid
		if params.target:IsBuilding() or params.target:IsOther() then
			return 0
		end

		-- fail if status is invalid
		if self:GetParent():IsIllusion() or self:GetParent():PassivesDisabled() then
			return 0
		end

		-- roll chance to proc strength
		local roll = RandomInt(1,100)
		if roll <= self.bonus_damage_chance then
			local bonusDamage = self.bonus_damage
			print("halberd Axe bonus damage proc: " .. bonusDamage)
			return bonusDamage
		end
		
		return 0
	end
end








