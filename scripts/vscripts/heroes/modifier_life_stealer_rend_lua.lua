modifier_life_stealer_rend_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_life_stealer_rend_lua:IsHidden()
	return true
end

function modifier_life_stealer_rend_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function modifier_life_stealer_rend_lua:OnCreated( kv )
	self.percent_chance = self:GetAbility():GetSpecialValueFor( "percent_chance" )
	self.armor_reduction_radius = self:GetAbility():GetSpecialValueFor( "armor_reduction_radius" )
	self.armor_reduction_duration = self:GetAbility():GetSpecialValueFor( "armor_reduction_duration" )
	self.percent_str_damage = self:GetAbility():GetSpecialValueFor( "percent_str_damage" )
end

function modifier_life_stealer_rend_lua:OnRefresh( kv )
	self.percent_chance = self:GetAbility():GetSpecialValueFor( "percent_chance" )
	self.armor_reduction_radius = self:GetAbility():GetSpecialValueFor( "armor_reduction_radius" )
	self.armor_reduction_duration = self:GetAbility():GetSpecialValueFor( "armor_reduction_duration" )
    self.percent_str_damage = self:GetAbility():GetSpecialValueFor( "percent_str_damage" )
end

function modifier_life_stealer_rend_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_life_stealer_rend_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

function modifier_life_stealer_rend_lua:GetModifierProcAttack_BonusDamage_Physical( params )
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
		if roll <= self.percent_chance then
			local strength = self:GetParent():GetStrength()
			local damage = strength * self.percent_str_damage / 100
			print("strength bonus damage proc: " .. damage)
			self.record = params.record -- trigger feedback function
			return damage
		end
		
		return 0
	end
end

function modifier_life_stealer_rend_lua:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		if params.record==self.record then
			--apply AOE debuff
			print("applying debuff...")

			-- Find Units in Radius
			local enemies = FindUnitsInRadius(
				self:GetCaster():GetTeamNumber(),	-- int, your team number
				self:GetParent():GetOrigin(),	-- point, center point
				nil,	-- handle, cacheUnit. (not known)
				self.armor_reduction_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
				DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
				DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
				0,	-- int, order filter
        		false	-- bool, can grow cache
			)
			
			for _,enemy in pairs(enemies) do
				if enemy~=self.parent then
					--add modifier
					enemy:AddNewModifier(
						self:GetParent(), -- player source
						self:GetAbility(), -- ability source
						"modifier_life_stealer_rend_lua_debuff", -- modifier name
						{ duration = self.armor_reduction_duration } -- kv
					)
				end
			end
		end
	end
end








