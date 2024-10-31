modifier_moo_crown_lua = class({})
--------------------------------------------------------------------------------
function modifier_moo_crown_lua:IsHidden()
	return true
end

function modifier_moo_crown_lua:IsDebuff()
	return false
end

function modifier_moo_crown_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_moo_crown_lua:OnCreated( kv )
    self.hero_range = self:GetAbility():GetSpecialValueFor( "hero_range" )

	self.active = true

	if not IsServer() then return end
	-- Start interval
	self:StartIntervalThink( 0.5 )
	self:OnIntervalThink()
end

function modifier_moo_crown_lua:OnRefresh( kv )
	self.hero_range = self:GetAbility():GetSpecialValueFor( "hero_range" )
end

function modifier_moo_crown_lua:OnDestroy()

end
-------------------------------------------------------------------------------
-- Interval Effects
function modifier_moo_crown_lua:OnIntervalThink()
	if IsServer() then
		-- check for allied hero
		local heroes = FindUnitsInRadius(
			self:GetParent():GetTeamNumber(),	-- int, your team number
			self:GetParent():GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self.hero_range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		if #heroes==0 then
			self.active = false
		else
			self.active = true
		end
	end
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_moo_crown_lua:IsAura()
	return self.active
end

function modifier_moo_crown_lua:GetModifierAura()
	return "modifier_moo_crown_lua_effect"
end

function modifier_moo_crown_lua:GetAuraRadius()
	return self.hero_range
end

function modifier_moo_crown_lua:GetAuraDuration()
	return 1.0
end

function modifier_moo_crown_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_moo_crown_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BUILDING 
end

function modifier_moo_crown_lua:GetAuraSearchFlags()
	return not DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED 
end
