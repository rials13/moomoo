modifier_lion_gun_flare_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lion_gun_flare_lua:IsHidden()
	return false
end

function modifier_lion_gun_flare_lua:IsDebuff()
	return true
end

function modifier_lion_gun_flare_lua:IsStunDebuff()
	return false
end

function modifier_lion_gun_flare_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lion_gun_flare_lua:OnCreated( kv )
	-- references
	if not IsServer() then return end
	local interval = kv.interval
	self.damage = kv.damage

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage, -- ncommented from original
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( interval )
end

function modifier_lion_gun_flare_lua:OnRefresh( kv )
	--if not IsServer() then return end
	--self.damage = kv.damage
end

function modifier_lion_gun_flare_lua:OnRemoved()
end

function modifier_lion_gun_flare_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_lion_gun_flare_lua:OnIntervalThink()
	-- check health
	--local damage = self:GetParent():GetMaxHealth() * self.damage_pct

	-- apply damage
	--self.damageTable.damage = damage
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_lion_gun_flare_lua:GetEffectName()
	return "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave_burn.vpcf"
end

function modifier_lion_gun_flare_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end