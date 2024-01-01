item_moo_moo_tshirt = class({})
LinkLuaModifier( "item_moo_moo_tshirt_modifier_passive", "items/item_moo_moo_tshirt_modifier_passive", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_moo_moo_tshirt_modifier_unleash", "items/item_moo_moo_tshirt_modifier_unleash", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_moo_moo_tshirt:GetIntrinsicModifierName()
    return "item_moo_moo_tshirt_modifier_passive"
end
--------------------------------------------------------------------------------

function item_moo_moo_tshirt:OnSpellStart()
    -- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCaster():GetAbsOrigin()

	-- load data
	local duration = self:GetSpecialValueFor("duration")
	
	-- Purge: Strong Dispel
	caster:Purge( false, true, false, true, true )
	
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"item_moo_moo_tshirt_modifier_unleash", -- modifier name
		{ duration = duration } -- kv
	)

	local sound_cast = "sounds/addons/conquest/glyph_10_seconds.vsnd"
	EmitSoundOn( sound_cast, caster )

end