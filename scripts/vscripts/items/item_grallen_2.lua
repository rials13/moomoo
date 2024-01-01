item_grallen_2 = class({})
LinkLuaModifier( "item_grallen_modifier_passive", "items/item_grallen_modifier_passive", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_grallen_modifier_hex", "items/item_grallen_modifier_hex", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_grallen_2:GetIntrinsicModifierName()
    return "item_grallen_modifier_passive"
end
--------------------------------------------------------------------------------

function item_grallen_2:OnSpellStart()
    -- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local duration = self:GetSpecialValueFor("duration")
	
	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"item_grallen_modifier_hex", -- modifier name
		{ duration = duration } -- kv
	)

	-- effects
	local sound_cast = "sounds/weapons/hero/lion/lion_voodoo.vsnd"
	EmitSoundOn( sound_cast, caster )

end
