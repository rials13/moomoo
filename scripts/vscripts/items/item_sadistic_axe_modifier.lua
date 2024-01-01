item_sadistic_axe_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_sadistic_axe_modifier:IsHidden()
	return false
end

function item_sadistic_axe_modifier:IsDebuff()
	return false
end

function item_sadistic_axe_modifier:IsPurgable()
	return false
end
-------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Initializations
function item_sadistic_axe_modifier:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
    self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	-- generate data
	self.parent = self:GetParent()==self:GetCaster()

    -- from centaur war runners stampede
    self.interval = 0.1
    self.haste = 550

	-- Start interval
	if IsServer() then
		-- Apply Damage	 
		self.damageTable = {
			-- victim = target,
			attacker = self:GetParent(),
			damage = self.damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = self:GetAbility(), --Optional.
		}

		-- Stampede
		self:StartIntervalThink( self.interval )
	end

end

function item_sadistic_axe_modifier:OnRefresh( kv )
    -- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
    self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	-- generate data
	--self.parent = self:GetParent()==self:GetCaster()
    --self.interval = 0.1
	if IsServer() then
		-- Apply Damage	 
		self.damageTable = {
			-- victim = target,
			attacker = self:GetParent(),
			damage = self.damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = self:GetAbility(), --Optional.
		}

		-- Stampede
		self:StartIntervalThink( self.interval )
	end
end

function item_sadistic_axe_modifier:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_sadistic_axe_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,

        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
        MODIFIER_EVENT_ON_ATTACK
	}

	return funcs
end

function item_sadistic_axe_modifier:GetModifierInvisibilityLevel()
	return 1 -- ghost walk =1 
end

function item_sadistic_axe_modifier:GetModifierMoveSpeed_AbsoluteMin()
	return self.haste
end

function item_sadistic_axe_modifier:OnAbilityExecuted( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end

		self:Destroy()
	end
end

function item_sadistic_axe_modifier:OnAttack( params )
	if IsServer() then
		if params.attacker~=self:GetParent() then return end

		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function item_sadistic_axe_modifier:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function item_sadistic_axe_modifier:OnIntervalThink()
	-- Find Units in Radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	local target = nil
	for _,enemy in pairs(enemies) do
		if not self:GetAbility():HasDamaged( enemy ) then
			target = enemy
		end
	end

	if target then
		-- Damage
		self.damageTable.victim = target
		ApplyDamage( self.damageTable )


		-- Effects
		self:PlayEffects( target )
	end
end

function item_sadistic_axe_modifier:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_weaver/weaver_shukuchi_damage.vpcf"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

