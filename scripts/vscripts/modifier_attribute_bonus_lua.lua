modifier_attribute_bonus_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_attribute_bonus_lua:IsHidden()
	return true
end

function modifier_attribute_bonus_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_attribute_bonus_lua:OnCreated( kv )
	-- references
	self.all_stats = self:GetAbility():GetSpecialValueFor( "all_stats" ) -- special value
end

function modifier_attribute_bonus_lua:OnRefresh( kv )
	-- references
	self.all_stats = self:GetAbility():GetSpecialValueFor( "all_stats" ) -- special value
end

function modifier_attribute_bonus_lua:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_attribute_bonus_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}

	return funcs
end

function modifier_attribute_bonus_lua:GetModifierBonusStats_Strength()
	if IsServer() then
		return self:GetAbility():GetLevel() * self.all_stats
	end
end

function modifier_attribute_bonus_lua:GetModifierBonusStats_Agility()
	if IsServer() then
		return self:GetAbility():GetLevel() * self.all_stats
	end
end

function modifier_attribute_bonus_lua:GetModifierBonusStats_Intellect()
	if IsServer() then
		return self:GetAbility():GetLevel() * self.all_stats
	end
end
