modifier_drow_ranger_accuracy_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_drow_ranger_accuracy_lua:IsHidden()
	return true
end

function modifier_drow_ranger_accuracy_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_drow_ranger_accuracy_lua:OnCreated( kv )
	-- references
	self.bonus_agi = self:GetAbility():GetSpecialValueFor( "bonus_agi" ) -- special value
end

function modifier_drow_ranger_accuracy_lua:OnRefresh( kv )
	-- references
	self.bonus_agi = self:GetAbility():GetSpecialValueFor( "bonus_agi" ) -- special value	
end

function modifier_drow_ranger_accuracy_lua:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_drow_ranger_accuracy_lua:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}

	return funcs
end

function modifier_drow_ranger_accuracy_lua:GetModifierBonusStats_Agility()
	if IsServer() then
		return self.bonus_agi
	end
end
