modifier_razor_troys_strength_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_razor_troys_strength_lua:IsHidden()
	return true
end

function modifier_razor_troys_strength_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_razor_troys_strength_lua:OnCreated( kv )
	-- references
	self.bonus_str_agi = self:GetAbility():GetSpecialValueFor( "bonus_str_agi" ) -- special value
end

function modifier_razor_troys_strength_lua:OnRefresh( kv )
	-- references
	self.bonus_str_agi = self:GetAbility():GetSpecialValueFor( "bonus_str_agi" ) -- special value	
end

function modifier_razor_troys_strength_lua:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_razor_troys_strength_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}

	return funcs
end

function modifier_razor_troys_strength_lua:GetModifierBonusStats_Strength()
	if IsServer() then
		return self.bonus_str_agi
	end
end

function modifier_razor_troys_strength_lua:GetModifierBonusStats_Agility()
	if IsServer() then
		return self.bonus_str_agi
	end
end
