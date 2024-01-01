modifier_life_stealer_stench_lua = class({})
--------------------------------------------------------------------------------
function modifier_life_stealer_stench_lua:IsHidden()
	return true
end

function modifier_life_stealer_stench_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_life_stealer_stench_lua:IsAura()
	if self:GetCaster() == self:GetParent() then
		return true
	end
	
	return false
end

--------------------------------------------------------------------------------

function modifier_life_stealer_stench_lua:GetModifierAura()
	return "modifier_life_stealer_stench_lua"
end

--------------------------------------------------------------------------------

function modifier_life_stealer_stench_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

--------------------------------------------------------------------------------

function modifier_life_stealer_stench_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------

function modifier_life_stealer_stench_lua:GetAuraRadius()
	return self.radius
end

--------------------------------------------------------------------------------

function modifier_life_stealer_stench_lua:OnCreated( kv )
    self.damage_per_tick = self:GetAbility():GetSpecialValueFor( "damage_per_tick" )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if IsServer() then
		if self:GetParent() == self:GetCaster() then
            EmitSoundOn( "Hero_Pudge.Rot", self:GetCaster() )
			self.damage_per_tick = 0 -- do not damage yourself
			local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_pudge/pudge_rot.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
			ParticleManager:SetParticleControl( nFXIndex, 1, Vector( self.radius, 1, self.radius ) )
			self:AddParticle( nFXIndex, false, false, -1, false, false )
		else
			local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_pudge/pudge_rot_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
			self:AddParticle( nFXIndex, false, false, -1, false, false )
		end

		self:StartIntervalThink( 0.2 )
		self:OnIntervalThink()
	end
end

--------------------------------------------------------------------------------

function modifier_life_stealer_stench_lua:OnDestroy()
	if IsServer() then
		--StopSoundOn( "Hero_Pudge.Rot", self:GetCaster() )
	end
end

--------------------------------------------------------------------------------

function modifier_life_stealer_stench_lua:OnIntervalThink()
	if IsServer() then
		if self.damage_per_tick == 0.0 then 
			return
		else
			local flDamagePerTick =  self.damage_per_tick

			if self:GetCaster():IsAlive() then
				local damage = {
					victim = self:GetParent(),
					attacker = self:GetCaster(),
					damage = flDamagePerTick,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self:GetAbility()
				}

				ApplyDamage( damage )
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------