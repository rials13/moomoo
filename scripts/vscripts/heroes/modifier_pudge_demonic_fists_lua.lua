modifier_pudge_demonic_fists_lua = class({})
--------------------------------------------------------------------------------

function modifier_pudge_demonic_fists_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_pudge_demonic_fists_lua:IsAura()
	return false
end

--------------------------------------------------------------------------------

function modifier_pudge_demonic_fists_lua:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.attack_spd_pct = self:GetAbility():GetSpecialValueFor( "attack_spd_pct" )
	self.aoe_dps = self:GetAbility():GetSpecialValueFor( "aoe_dps" )
	self.self_dps = self:GetAbility():GetSpecialValueFor( "self_dps" )
	self.tick = self:GetAbility():GetSpecialValueFor( "tick" )

	-- alter damage to tick rate:
	self.self_tick_dmg = self.self_dps * self.tick

	if IsServer() then
		EmitSoundOn( "Hero_Pudge.Rot", self:GetCaster() )
		local nFXIndex = ParticleManager:CreateParticle( "particles/items_fx/armlet.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		self:AddParticle( nFXIndex, false, false, -1, false, false )

		self:StartIntervalThink( self.tick )
		self:OnIntervalThink()
	end
end

--------------------------------------------------------------------------------

function modifier_pudge_demonic_fists_lua:OnDestroy()
	if IsServer() then
		StopSoundOn( "Hero_Pudge.Rot", self:GetCaster() )
	end
end

--------------------------------------------------------------------------------

function modifier_pudge_demonic_fists_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}

	return funcs
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function modifier_pudge_demonic_fists_lua:GetModifierProcAttack_Feedback( params )
	if params.target:GetTeamNumber()==self:GetParent():GetTeamNumber() then return end

	-- splash damage

	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		params.target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		if enemy~=params.target then
			-- -- perform attack
			-- self.parent:PerformAttack(
			-- 	enemy, -- hTarget,
			-- 	false, -- bUseCastAttackOrb,
			-- 	false, -- bProcessProcs,
			-- 	true, -- bSkipCooldown,
			-- 	true, -- bIgnoreInvis,
			-- 	false, -- bUseProjectile,
			-- 	false, -- bFakeAttack,
			-- 	true -- bNeverMiss
			-- )

			-- apply damage
			local damageTable = {
				victim = enemy,
				attacker = self:GetParent(),
				damage = self.aoe_dps,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self:GetAbility(), --Optional.
				-- damage_category = DOTA_DAMAGE_CATEGORY_ATTACK, --Optional.
			}
			ApplyDamage(damageTable)
		end
	end
end

function modifier_pudge_demonic_fists_lua:GetModifierAttackSpeedPercentage()
		return self.attack_spd_pct
end

function modifier_pudge_demonic_fists_lua:OnTooltip()
	return self.self_dps
end

--------------------------------------------------------------------------------

function modifier_pudge_demonic_fists_lua:OnIntervalThink()
	if IsServer() then

		local damage = self.self_tick_dmg
		

		if self:GetCaster():IsAlive() then
			local damage = {
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self:GetAbility()
			}

			ApplyDamage( damage )
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------