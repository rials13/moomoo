modifier_razor_bryans_breath_lua = class({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_razor_bryans_breath_lua:IsHidden()
	return false
end

function modifier_razor_bryans_breath_lua:IsDebuff()
	return true
end

function modifier_razor_bryans_breath_lua:IsStunDebuff()
	return false
end

function modifier_razor_bryans_breath_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_razor_bryans_breath_lua:OnCreated( kv )
	-- references
	self.movement_slow = self:GetAbility():GetSpecialValueFor( "movement_slow" )
    self.duration_damage = self:GetAbility():GetSpecialValueFor( "duration_damage" )

	if IsServer() then
		-- Initialize Damage Table	 
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.duration_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self, --Optional.
		}
		
		-- Start interval
		self:StartIntervalThink( 1 ) -- 1 second ticks
        self:OnIntervalThink()
		-- play effects
		self:PlayEffects()
	end
end

function modifier_razor_bryans_breath_lua:OnRefresh( kv )
end

function modifier_razor_bryans_breath_lua:OnRemoved()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_razor_bryans_breath_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_razor_bryans_breath_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.movement_slow
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_razor_bryans_breath_lua:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_queen_of_pain_shadow_strike_lua:GetEffectName()
-- 	return "particles/units/heroes/hero_queenofpain/queen_shadow_strike_debuff.vpcf"
-- end

-- function modifier_queen_of_pain_shadow_strike_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

function modifier_razor_bryans_breath_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_viper/viper_nethertoxin_debuff_splash.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
end