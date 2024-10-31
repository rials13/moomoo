modifier_moo_healing_lua = class({})
--------------------------------------------------------------------------------
function modifier_moo_healing_lua:IsHidden()
	if self:GetCaster() == self:GetParent() then
		return true
	end
	
	return false
end
--------------------------------------------------------------------------------
function modifier_moo_healing_lua:IsAura()
	if self:GetCaster() == self:GetParent() then
		return true
	end
	
	return false
end
--------------------------------------------------------------------------------
function modifier_moo_healing_lua:GetModifierAura()
	return "modifier_moo_healing_lua"
end

--------------------------------------------------------------------------------

function modifier_moo_healing_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

--------------------------------------------------------------------------------

function modifier_moo_healing_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_moo_healing_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED
end

--------------------------------------------------------------------------------

function modifier_moo_healing_lua:GetAuraRadius()
	return self.heal_range
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Initializations
function modifier_moo_healing_lua:OnCreated( kv )
    self.heal_range = self:GetAbility():GetSpecialValueFor( "heal_range" )
	self.hp_regen_max = self:GetAbility():GetSpecialValueFor( "hp_regen_max" )
	self.hp_regen = self.hp_regen_max

	if not IsServer() then return end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	-- Start interval
	self:StartIntervalThink( 0.2 )
	self:OnIntervalThink()
end

function modifier_moo_healing_lua:OnRefresh( kv )
	self.heal_range = self:GetAbility():GetSpecialValueFor( "heal_range" )
	self.hp_regen_max = self:GetAbility():GetSpecialValueFor( "hp_regen_max" )

end

function modifier_moo_healing_lua:OnDestroy()

end
-------------------------------------------------------------------------------
-- Interval Effects
function modifier_moo_healing_lua:OnIntervalThink()
	if not IsServer() then return end
	if self.caster == self.parent then return end
	-- get distance for each unit
	local distance = (self.caster:GetOrigin()- self.parent:GetOrigin()):Length2D()
	--print(distance)
	local health_regen = ((self.heal_range - distance) / self.heal_range) * self.hp_regen_max
	if health_regen < 0 then return end
	self.hp_regen = health_regen
	self.parent:AddNewModifier(
		self.parent,
		self,
		"modifier_moo_healing_lua_effect", -- modifier name
		{
			health_regen = health_regen,
	 		duration = 0.5
	 	} -- kv
	)
	--print(health_regen)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_moo_healing_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOOLTIP ,
	}

	return funcs
end

function modifier_moo_healing_lua:OnTooltip()
	return self.hp_regen
end

-- from earlier code	

-- if IsServer() then
	-- 	-- check for ally
	-- 	local heroes = FindUnitsInRadius(
	-- 		self:GetParent():GetTeamNumber(),	-- int, your team number
	-- 		self:GetParent():GetOrigin(),	-- point, center point
	-- 		nil,	-- handle, cacheUnit. (not known)
	-- 		self.heal_range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
	-- 		DOTA_UNIT_TARGET_TEAM_FRIENDLY ,	-- int, team filter
	-- 		DOTA_UNIT_TARGET_HERO ,	-- int, type filter
	-- 		0,	-- int, flag filter
	-- 		0,	-- int, order filter
	-- 		false	-- bool, can grow cache
	-- 	)
	-- 	if #heroes > 0 then
	-- 		for _,hero in pairs(heroes) do
	-- 			-- calculate distance
	-- 			local distance = (hero:GetOrigin()-self:GetParent():GetOrigin()):Length2D()
	-- 			print(distance)
	-- 			-- calc heal based on distance 
	-- 			local health_regen = ((self.heal_range - distance) / self.heal_range) * self.hp_regen_max
	-- 			print(health_regen)
	-- 			hero:AddNewModifier(
	-- 				self:GetParent(), -- player source
	-- 				self, -- ability source
	-- 				"modifier_moo_healing_lua_effect", -- modifier name
	-- 				{
	-- 					health_regen = health_regen,
	-- 					duration = 0.5
	-- 				} -- kv
	-- 			)
	-- 		end
	-- 	end
	-- end

