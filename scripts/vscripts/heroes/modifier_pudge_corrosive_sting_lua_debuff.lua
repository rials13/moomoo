modifier_pudge_corrosive_sting_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_pudge_corrosive_sting_lua_debuff:IsHidden()
	return false
end

function modifier_pudge_corrosive_sting_lua_debuff:IsDebuff()
	return true
end

function modifier_pudge_corrosive_sting_lua_debuff:IsStunDebuff()
	return false
end

function modifier_pudge_corrosive_sting_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_pudge_corrosive_sting_lua_debuff:OnCreated( kv )
	self.parent = self:GetParent()
	self.caster = self:GetCaster()

	-- references
	local dps = self:GetAbility():GetSpecialValueFor( "dps" )
	self.slow_pct = self:GetAbility():GetSpecialValueFor( "slow_pct" )

	if not IsServer() then return end
	-- precache damage
	self.damageTable = {
		victim = self.parent,
		attacker = self.caster,
		damage = dps,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( 1 )
	self:OnIntervalThink()
end

function modifier_pudge_corrosive_sting_lua_debuff:OnRefresh( kv )
	-- references
	self:OnCreated( kv )
end

function modifier_pudge_corrosive_sting_lua_debuff:OnRemoved()
end

function modifier_pudge_corrosive_sting_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_pudge_corrosive_sting_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_pudge_corrosive_sting_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow_pct
	
end


--------------------------------------------------------------------------------
-- Interval Effects
function modifier_pudge_corrosive_sting_lua_debuff:OnIntervalThink()
	-- Apply damage
	ApplyDamage( self.damageTable )

	-- overhead damage info
	SendOverheadEventMessage(
		nil,
		OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
		self.parent,
		self.damageTable.damage,
		self.caster:GetPlayerOwner()
	)
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_pudge_corrosive_sting_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_venomancer/venomancer_poison_debuff.vpcf"
end

function modifier_pudge_corrosive_sting_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end