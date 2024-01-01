item_book_of_knowledge_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_book_of_knowledge_modifier:IsHidden()
	return true
end

function item_book_of_knowledge_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function item_book_of_knowledge_modifier:OnCreated( kv )
	-- references
	self.all_stats = self:GetAbility():GetSpecialValueFor( "all_stats" )
	self.exp_rate = self:GetAbility():GetSpecialValueFor( "exp_rate" )

	--self.exp_rate = self.exp_rate / 100
end

function item_book_of_knowledge_modifier:OnRefresh( kv )
	-- references
	self:OnCreated( kv )
end

function item_book_of_knowledge_modifier:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_book_of_knowledge_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,

		MODIFIER_PROPERTY_EXP_RATE_BOOST
	}

	return funcs
end

function item_book_of_knowledge_modifier:GetModifierBonusStats_Strength( params )
	return self.all_stats
end

function item_book_of_knowledge_modifier:GetModifierBonusStats_Agility( params )
	return self.all_stats
end

function item_book_of_knowledge_modifier:GetModifierBonusStats_Intellect( params )
	return self.all_stats
end

function item_book_of_knowledge_modifier:GetModifierPercentageExpRateBoost( params )
	return self.exp_rate
end

