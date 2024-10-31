modifier_drow_ranger_death_shot_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_drow_ranger_death_shot_lua:IsHidden()
	return true
end

function modifier_drow_ranger_death_shot_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_drow_ranger_death_shot_lua:OnCreated( kv )
	-- references
	self.crit_chance_day = self:GetAbility():GetSpecialValueFor( "crit_chance_day" )
	self.crit_chance_night = self:GetAbility():GetSpecialValueFor( "crit_chance_night" )
	self.agi_mult = self:GetAbility():GetSpecialValueFor( "agi_mult" )
	self.crit_chance = self.crit_chance_day
	self:StartIntervalThink( 1.0 )
	self:OnIntervalThink()
end

function modifier_drow_ranger_death_shot_lua:OnRefresh( kv )
	-- references
	self.crit_chance_day = self:GetAbility():GetSpecialValueFor( "crit_chance_day" )
	self.crit_chance_night = self:GetAbility():GetSpecialValueFor( "crit_chance_night" )
	self.agi_mult = self:GetAbility():GetSpecialValueFor( "agi_mult" )
end

function modifier_drow_ranger_death_shot_lua:OnDestroy( kv )

end
--------------------------------------------------------------------------------
---interval
function modifier_drow_ranger_death_shot_lua:OnIntervalThink()
	-- get day and night vision and compare to current
	local dayVision = self:GetParent():GetDayTimeVisionRange()
	local nightVision = self:GetParent():GetNightTimeVisionRange()
	local currentVision = self:GetParent():GetCurrentVisionRange()
	if currentVision == dayVision then
		--print("Dayvision")
		self.crit_chance = self.crit_chance_day
	elseif currentVision == nightVision then
		--print("night Vision")
		self.crit_chance = self.crit_chance_night
	else 
		--print("no match vision")
	end
end
--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_drow_ranger_death_shot_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

function modifier_drow_ranger_death_shot_lua:GetModifierPreAttack_BonusDamage( params )
	self.damage = self.agi_mult * self:GetParent():GetAgility()
    return self.damage
end

function modifier_drow_ranger_death_shot_lua:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		-- fail if target is invalid
		if params.target:IsBuilding() or params.target:IsOther() then
			return 0
		end

		-- fail if status is invalid
		if self:GetParent():IsIllusion() or self:GetParent():PassivesDisabled() then
			return 0
		end

		-- roll chance to proc
		local roll = RandomInt(1,100)
		if roll <= self.crit_chance then
			local bonusDamage = self.damage
			print("Agi bonus damage Death Shot: " .. bonusDamage)
			--print("actual crit chance" .. self.crit_chance)
			return bonusDamage
		end
		
		return 0
	end
end