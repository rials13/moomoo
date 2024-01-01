item_prismatic = class({})
LinkLuaModifier( "item_prismatic_modifier_passive", "items/item_prismatic_modifier_passive", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_prismatic_modifier_arcanite", "items/item_prismatic_modifier_arcanite", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_prismatic_modifier_aura", "items/item_prismatic_modifier_aura", LUA_MODIFIER_MOTION_NONE )
--------------------------------------------------------------------------------
-- Passive Modifiers
function item_prismatic:GetIntrinsicModifierName()
    return "item_prismatic_modifier_passive"
end
--------------------------------------------------------------------------------

function item_prismatic:OnSpellStart()
    -- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCaster():GetAbsOrigin()

	-- load data
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")
	
	-- Find Units in Radius
	local allies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY ,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)
	
	-- add modifier
	for _,ally in pairs(allies) do
		-- Add modifier
		ally:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"item_prismatic_modifier_arcanite", -- modifier name
			{ duration = duration } -- kv
		)
	end

	self:PlayEffects()

end

function item_prismatic:PlayEffects()
	local particle_cast = "particles/items2_fx/mekanism.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	local sound_cast = "DOTA_Item.Mekansm.Activate"
	EmitSoundOn( sound_cast, self:GetCaster() )



end
