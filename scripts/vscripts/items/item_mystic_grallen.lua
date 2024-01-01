item_mystic_grallen = class({})
LinkLuaModifier( "item_mystic_grallen_modifier_passive", "items/item_mystic_grallen_modifier_passive", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_mystic_grallen_modifier_hex", "items/item_mystic_grallen_modifier_hex", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_mystic_grallen:GetIntrinsicModifierName()
    return "item_mystic_grallen_modifier_passive"
end
--------------------------------------------------------------------------------
-- AOE Radius
function item_mystic_grallen:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end
--------------------------------------------------------------------------------
-- Ability Start
function item_mystic_grallen:OnSpellStart()
    -- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")
	
	-- Find Units in Radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- Add modifier
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"item_mystic_grallen_modifier_hex", -- modifier name
			{ duration = duration } -- kv
		)
	end

	-- effects
	local sound_cast = "sounds/weapons/hero/lion/lion_voodoo.vsnd"
	EmitSoundOn( sound_cast, caster )

end
