pudge_demonic_fists_lua = class({})
LinkLuaModifier( "modifier_pudge_demonic_fists_lua", "heroes/modifier_pudge_demonic_fists_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function pudge_demonic_fists_lua:ProcsMagicStick()
	return false
end

--------------------------------------------------------------------------------

function pudge_demonic_fists_lua:OnToggle()
	if self:GetToggleState() then
		self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_pudge_demonic_fists_lua", nil )

		if not self:GetCaster():IsChanneling() then
			self:GetCaster():StartGesture( ACT_DOTA_CAST_ABILITY_ROT )
		end

	else
		local hdemonic_fistsBuff = self:GetCaster():FindModifierByName( "modifier_pudge_demonic_fists_lua" )
		if hdemonic_fistsBuff ~= nil then
			hdemonic_fistsBuff:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
function pudge_demonic_fists_lua:GetAbilityTextureName()
    if self:GetCaster():HasModifier( "modifier_pudge_demonic_fists_lua" ) then
        return "pudge_demonic_fists_active"
    else
        return "pudge_demonic_fists"
    end
end
