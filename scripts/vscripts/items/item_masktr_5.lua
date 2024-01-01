item_masktr_5 = class({})
LinkLuaModifier( "item_masktr_modifier", "items/item_masktr_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_masktr_modifier_passive", "items/item_masktr_modifier_passive", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function item_masktr_5:GetIntrinsicModifierName()
	return "item_masktr_modifier_passive"
end

--------------------------------------------------------------------------------
-- Ability Start
function item_masktr_5:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local bDuration = self:GetSpecialValueFor("duration")

    -- set cooldown
    self:UseResources( false, false, true ) 

	-- Add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"item_masktr_modifier", -- modifier name
		{ duration = bDuration } -- kv
	)
    -- Play effects
	self:PlayEffects()
end

--------------------------------------------------------------------------------
function item_masktr_5:PlayEffects()
	-- Get Resources
	local sound_cast = "sounds/items/item_satanic.vsnd"
	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end