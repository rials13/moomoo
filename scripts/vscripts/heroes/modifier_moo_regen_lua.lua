modifier_moo_regen_lua = class({})
--------------------------------------------------------------------------------
function modifier_moo_regen_lua:IsHidden()
	return true
end

function modifier_moo_regen_lua:IsDebuff()
	return false
end

function modifier_moo_regen_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_moo_regen_lua:OnCreated( kv )
    self.enemy_range = self:GetAbility():GetSpecialValueFor( "enemy_range" )

	self.active = false

	if not IsServer() then return end
	-- Start interval
	self:StartIntervalThink( 0.5 )
	self:OnIntervalThink()
end

function modifier_moo_regen_lua:OnRefresh( kv )
	self.enemy_range = self:GetAbility():GetSpecialValueFor( "enemy_range" )
end

function modifier_moo_regen_lua:OnDestroy()

end
-------------------------------------------------------------------------------
-- Interval Effects
function modifier_moo_regen_lua:OnIntervalThink()
	if IsServer() then
		-- check for enemy
		local enemy = FindUnitsInRadius(
			self:GetParent():GetTeamNumber(),	-- int, your team number
			self:GetParent():GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self.enemy_range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_ALL,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		if #enemy==0 then
			self.active = true
		else
			self.active = false
		end
	end
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_moo_regen_lua:IsAura()
	return self.active
end

function modifier_moo_regen_lua:GetModifierAura()
	return "modifier_moo_regen_lua_effect"
end

function modifier_moo_regen_lua:GetAuraRadius()
	return self.enemy_range
end

function modifier_moo_regen_lua:GetAuraDuration()
	return 1.0
end

function modifier_moo_regen_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_moo_regen_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BUILDING 
end

function modifier_moo_regen_lua:GetAuraSearchFlags()
	return not DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED 
end
