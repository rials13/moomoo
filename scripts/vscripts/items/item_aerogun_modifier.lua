item_aerogun_modifier = class({})
--------------------------------------------------------------------------------
function item_aerogun_modifier:IsHidden()
	return true
end

function item_aerogun_modifier:IsDebuff()
	return false
end

--------------------------------------------------------------------------------

function item_aerogun_modifier:OnCreated( kv )
    self.strength = self:GetAbility():GetSpecialValueFor( "strength" )
    self.hp_regen = self:GetAbility():GetSpecialValueFor( "hp_regen" )
	self.buff_duration = self:GetAbility():GetSpecialValueFor( "buff_duration" )
end

function item_aerogun_modifier:OnRefresh( kv )
    self.strength = self:GetAbility():GetSpecialValueFor( "strength" )
    self.hp_regen = self:GetAbility():GetSpecialValueFor( "hp_regen" )
	self.buff_duration = self:GetAbility():GetSpecialValueFor( "buff_duration" )
end

function item_aerogun_modifier:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_aerogun_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}

	return funcs
end

function item_aerogun_modifier:GetModifierBonusStats_Strength()
    return self.strength
end

function item_aerogun_modifier:GetModifierConstantHealthRegen()
    return self.hp_regen
end

function item_aerogun_modifier:OnAttackLanded( params )
	if IsServer() then
		-- check allies
		if params.target:GetTeamNumber()==self:GetParent():GetTeamNumber() then return end

		-- check spell immunity
		if params.target:IsMagicImmune() then return end

		--check hero is actually a hero and not a summon or other unit
		if not params.attacker:IsRealHero() and params.attacker:IsSummoned() then return end

		-- add debuff if not present
		local modifier = params.target:FindModifierByNameAndCaster( "item_aerogun_modifier_debuff", self:GetParent() )
        -- original code does nothing if the debuff is applied.
        -- this code refreshes the modifier
		--if not modifier then
			params.target:AddNewModifier(
				self:GetParent(), -- player source
				self:GetAbility(), -- ability source
				"item_aerogun_modifier_debuff", -- modifier name
				{ duration = self.buff_duration } -- kv
			)
		--end
	end
end