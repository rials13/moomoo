item_warlock_skull_3 = class({})
LinkLuaModifier( "item_warlock_skull_modifier_passive", "items/item_warlock_skull_modifier_passive", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_warlock_skull_modifier_avatar", "items/item_warlock_skull_modifier_avatar", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_warlock_skull_3:GetIntrinsicModifierName()
    return "item_warlock_skull_modifier_passive"
end
--------------------------------------------------------------------------------

function item_warlock_skull_3:OnSpellStart()
    -- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- Purge: Strong Dispel
	caster:Purge( false, true, false, true, true )
	
	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"item_warlock_skull_modifier_avatar", -- modifier name
		{ duration = duration } -- kv
	)

	-- effects
	local sound_cast = "sounds/weapons/hero/undying/flesh_golem_cast.vsnd"
	EmitSoundOn( sound_cast, caster )

end
