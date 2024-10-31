lion_hell_fire_lua = class({})
LinkLuaModifier( "modifier_lion_hell_fire_lua", "heroes/modifier_lion_hell_fire_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function lion_hell_fire_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- Add modifier
	self.modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_lion_hell_fire_lua", -- modifier name
		{ duration = self:GetChannelTime() } -- kv
	)
end

--------------------------------------------------------------------------------
-- Ability Channeling
function lion_hell_fire_lua:OnChannelFinish( bInterrupted )
	if self.modifier then
		self:GetCaster():RemoveModifierByName("modifier_lion_hell_fire_lua")
		--self.modifier:Destroy()
		--self.modifier = nil
	end
end