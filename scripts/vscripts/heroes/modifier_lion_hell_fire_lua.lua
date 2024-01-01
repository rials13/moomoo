modifier_lion_hell_fire_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lion_hell_fire_lua:IsHidden()
	return true
end

function modifier_lion_hell_fire_lua:IsDebuff()
	return false
end

function modifier_lion_hell_fire_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lion_hell_fire_lua:OnCreated( kv )
	-- load data
	local damage = self:GetCaster():GetIntellect()
	local spellLevel = self:GetAbility():GetLevel()
	if spellLevel >= 2 then
		damage = damage + self:GetCaster():GetAgility()
	end
	if spellLevel == 3 then
		damage = damage + self:GetCaster():GetStrength()
	end 

	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.count = self:GetAbility():GetSpecialValueFor( "wave_count" )
	self.interval = self:GetAbility():GetSpecialValueFor( "wave_interval" )

	if IsServer() then
		-- set wave counter
		self.wave = 0
		-- precache damage
		self.damageTable = {
			--victim = self:GetParent(), we'll get this OnThink with the finUnitsInRadius
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self, --Optional.
		}
		print("damage: " .. damage)

		-- start interval
		self:StartIntervalThink( self.interval )
		self:OnIntervalThink()

		-- play effects
		self:PlayEffects1()

	end
end

function modifier_lion_hell_fire_lua:OnRemoved( kv )
	if IsServer() then
		self:StartIntervalThink( -1 )
		self:StopEffects1()
	end
end

function modifier_lion_hell_fire_lua:OnDestroy( kv )
	if IsServer() then
		self:StartIntervalThink( -1 )
		self:StopEffects1()
	end
end

--------------------------------------------------------------------------------
-- Interval
function modifier_lion_hell_fire_lua:OnIntervalThink()
	if IsServer() then 
		-- find enemies
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),	-- int, your team number
			self:GetCaster():GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		for _,enemy in pairs(enemies) do
			-- damage
			self.damageTable.victim = enemy
			ApplyDamage( self.damageTable )
		end

		-- Paly effects?
		print("thinking...")
		-- increment wave
		self.wave = self.wave + 1
		if self.wave>=self.count then
			self:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Effects
function modifier_lion_hell_fire_lua:PlayEffects1()
	local particle_cast = "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf"
	self.sound_cast = "hero_Crystal.freezingField.wind"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	--self.effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, self.radius, 1 ) )
	self:AddParticle(
		self.effect_cast,
		false,
		false,
		-1,
		false,
		false
	)

	-- Play sound
	EmitSoundOn( self.sound_cast, self:GetCaster() )
end

function modifier_lion_hell_fire_lua:StopEffects1()
	StopSoundOn( self.sound_cast, self:GetCaster() )
end
