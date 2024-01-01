modifier_razor_ronels_skin_lua = class({})
--------------------------------------------------------------------------------
function modifier_razor_ronels_skin_lua:IsHidden()
	return true
end

function modifier_razor_ronels_skin_lua:IsDebuff()
	return false
end

--------------------------------------------------------------------------------

function modifier_razor_ronels_skin_lua:IsAura()
    return true
end

--------------------------------------------------------------------------------

function modifier_razor_ronels_skin_lua:GetModifierAura()
	return "modifier_razor_ronels_skin_lua_effect"
end

--------------------------------------------------------------------------------

function modifier_razor_ronels_skin_lua:GetAuraRadius()
	return self.radius
end

--------------------------------------------------------------------------------
function modifier_razor_ronels_skin_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

--------------------------------------------------------------------------------

function modifier_razor_ronels_skin_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------

function modifier_razor_ronels_skin_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE 
end

--------------------------------------------------------------------------------

function modifier_razor_ronels_skin_lua:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    
    if IsServer() then
		self:PlayEffects()
	end
end

function modifier_razor_ronels_skin_lua:OnRefresh( kv )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_razor_ronels_skin_lua:OnDestroy()

end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_razor_ronels_skin_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_viper/viper_nethertoxin_debuff.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	--ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
end