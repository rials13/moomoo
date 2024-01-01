item_trinity_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_trinity_modifier:IsHidden()
	return false
end

function item_trinity_modifier:IsPurgable()
	return false
end

function item_trinity_modifier:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end
--------------------------------------------------------------------------------
-- Initializations
function item_trinity_modifier:OnCreated( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.health_regen = self:GetAbility():GetSpecialValueFor( "health_regen" )
	self.mana_regen = self:GetAbility():GetSpecialValueFor( "mana_regen" )
	self.stats_damage_mult = self:GetAbility():GetSpecialValueFor( "stats_damage_mult" )	
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.crit_damage_mult = self:GetAbility():GetSpecialValueFor( "crit_damage_mult" )

	self.parent = self:GetParent()

	-- pre-calculate damage for STR/AGI/INT:
	local str = self.parent:GetStrength()
	local agi = self.parent:GetAgility()
	local int = self.parent:GetIntellect()
	self.stats_damage = (str + agi + int) * self.stats_damage_mult
	-- Add stack count to show bonus damage
	--self:SetModifierStacks(self.stats_damage)
	
	-- will be changed dynamically for talents
	self.use_modifier = false

	if not IsServer() then return end
	--self.original_projectile = self.parent:GetRangedProjectileName()
	--self.projectile_name = self.parent:GetRangedProjectileName()
	self.projectile_name = "particles/econ/items/ancient_apparition/aa_2021_immortal/aa_2021_immortal_chilling_projectile.vpcf"
	--self.parent:SetRangedProjectileName(self.projectile_name)
	self.projectile_speed = self.parent:GetProjectileSpeed()
end

function item_trinity_modifier:OnRefresh( kv )
	-- references
	self:OnCreated( kv )
end

function item_trinity_modifier:OnRemoved( kv )
	-- unset the projectile
	--if not self.parent or not self.original_projectile then return end
	--self.parent:SetRangedProjectileName(self.original_projectile)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_trinity_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE,

		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,

		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,

		MODIFIER_PROPERTY_PROJECTILE_NAME,
	}

	return funcs
end

function item_trinity_modifier:GetModifierPreAttack_BonusDamage	( params )
	
	-- Add base damage increase
	local total_damage = self.stats_damage + self.damage
	return total_damage
end

function item_trinity_modifier:GetModifierConstantHealthRegen( params )
	return self.health_regen
end

function item_trinity_modifier:GetModifierPercentageManaRegen( params )
	return self.mana_regen
end

function item_trinity_modifier:OnAttack( params )
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

function item_trinity_modifier:GetModifierPreAttack_CriticalStrike( params )
	if IsServer() then
		if self:RollChance( self.crit_chance ) then
			self.record = params.record
			return self.crit_damage_mult
		end
	end
end

function item_trinity_modifier:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		if self.record and self.record == params.record then
			self.record = nil

			-- Play effects
			local sound_cast = "Hero_Juggernaut.BladeDance"
			EmitSoundOn( sound_cast, params.target )
		end
	end
end

function item_trinity_modifier:OnTooltip()
	return self.stats_damage / self.stats_damage_mult
end
function item_trinity_modifier:OnTooltip2()
	return self.stats_damage
end

function item_trinity_modifier:GetModifierProjectileName( params )
	if not IsServer() then return end
	return self.projectile_name
end

--------------------------------------------------------------------------------
-- Helper
function item_trinity_modifier:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end

function item_trinity_modifier:MultiShotNoModifier( target )
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

function item_trinity_modifier:SetModifierStacks( damage )
	self.parent:SetModifierStackCount("item_trinity_modifier", self.parent, damage)
end

