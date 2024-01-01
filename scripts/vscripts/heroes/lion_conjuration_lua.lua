lion_conjuration_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function lion_conjuration_lua:OnSpellStart()
	-- unit identifier
	caster = self:GetCaster()

	-- load data
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetAbilityDamage()

	-- Find Units in Radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_NONE,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- Apply Damage	 
	local damageTable = {
		attacker = caster,
        damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}

	for _,enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		ApplyDamage( damageTable )


		-- Effects
		self:PlayEffects2( enemy )
	end

	-- Effects
	self:PlayEffects1()
end

--------------------------------------------------------------------------------
--[[ Helper
function lion_conjuration_lua:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function lion_conjuration_lua:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function lion_conjuration_lua:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function lion_conjuration_lua:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end]]

--------------------------------------------------------------------------------
-- Effects
function lion_conjuration_lua:PlayEffects1()
	-- Get Resources
	--local particle_cast = "particles/units/heroes/hero_bristleback/bristleback_quill_spray.vpcf"
    local particle_cast = "models/items/queenofpain/queenofpain_arcana/debut/particles/lava/lava_splash_ambient_b.vpcf"
	local sound_cast = "Hero_Bristleback.QuillSpray.Cast"

	-- Create Particle
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )
	--local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function lion_conjuration_lua:PlayEffects2( target )
	local particle_cast = "particles/units/heroes/hero_bristleback/bristleback_quill_spray_impact.vpcf"
	local sound_cast = "Hero_Bristleback.QuillSpray.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end