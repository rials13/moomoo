item_mithril_rod_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_mithril_rod_modifier:IsHidden()
	return true
end

function item_mithril_rod_modifier:IsPurgable()
	return false
end

function item_mithril_rod_modifier:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end
--------------------------------------------------------------------------------
-- Initializations
function item_mithril_rod_modifier:OnCreated( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" )

	self.parent = self:GetParent()

	

	-- will be changed dynamically for talents
	self.use_modifier = false

	if not IsServer() then return end
	--self.original_projectile = self.parent:GetRangedProjectileName()
	--self.projectile_name = self.parent:GetRangedProjectileName()
	self.projectile_name = "particles/items_fx/desolator_projectile.vpcf"
	--self.parent:SetRangedProjectileName(self.projectile_name)
	self.projectile_speed = self.parent:GetProjectileSpeed()
end

function item_mithril_rod_modifier:OnRefresh( kv )
	-- references
	self:OnCreated( kv )
end

function item_mithril_rod_modifier:OnRemoved( kv )
	-- unset the projectile
	--if not self.parent or not self.original_projectile then return end
	--self.parent:SetRangedProjectileName(self.original_projectile)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_mithril_rod_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
	}

	return funcs
end

function item_mithril_rod_modifier:GetModifierPreAttack_BonusDamage( params )
	return self.damage
end

function item_mithril_rod_modifier:GetModifierAttackSpeedBonus_Constant( params )
	return self.attack_speed
end

function item_mithril_rod_modifier:OnAttack( params )
	if not IsServer() then return end
	if params.attacker~=self.parent then return end

	-- not proc for instant attacks
	if params.no_attack_cooldown then return end

	-- not proc for attacking allies
	if params.target:GetTeamNumber()==params.attacker:GetTeamNumber() then return end

	-- not proc if break
	if self.parent:PassivesDisabled() then return end

	-- not proc if attack can't use attack modifiers
	if not params.process_procs then return end

	-- not proc on split shot attacks, even if it can use attack modifier, to avoid endless recursive call and crash
	if self.multi_shot then return end

	-- split shot
	--if self.use_modifier then
	--	self:MultiShotModifier( params.target )
	--else

	--do not apply for melee attackers
	if self.parent:IsRangedAttacker() then
		self:MultiShotNoModifier( params.target )
	end
	--end
end

function item_mithril_rod_modifier:GetModifierProjectileName( params )
	if not IsServer() then return end
	return self.projectile_name
end

function item_mithril_rod_modifier:MultiShotNoModifier( target )
	-- get radius
	local radius = self.parent:Script_GetAttackRange()

	-- find other target units
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_COURIER,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- get targets
	local count = 0
	for _,enemy in pairs(enemies) do
		-- not target itself
		if enemy~=target then
			-- launch projectile
			local info = {
				Target = enemy,
				Source = self.parent,
				Ability = self:GetAbility(),	
				
				EffectName = self.projectile_name,
				iMoveSpeed = self.projectile_speed,
				bDodgeable = true,                           -- Optional
				-- bIsAttack = true,                                -- Optional
			}
			ProjectileManager:CreateTrackingProjectile(info)

			count = count + 1
			--if count>=self.count then break end
		end
	end

	-- play effects if splitshot
	if count>0 then
		local sound_cast = "Hero_Medusa.AttackSplit"
		EmitSoundOn( sound_cast, self.parent )
	end
end

