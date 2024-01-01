razor_bryans_breath_lua = class({})
LinkLuaModifier( "modifier_razor_bryans_breath_lua", "heroes/modifier_razor_bryans_breath_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function razor_bryans_breath_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	
    -- load data
    local radius = self:GetSpecialValueFor("radius")
    local strike_damage = self:GetSpecialValueFor("strike_damage")
    local duration = self:GetSpecialValueFor("duration")

    -- Find Units in Radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

    -- Apply Damage	 
	local damageTable = {
		attacker = caster,
        damage = strike_damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}

    for _,enemy in pairs(enemies) do
        -- damage
		damageTable.victim = enemy
		ApplyDamage( damageTable )

		-- Add modifier
		enemy:AddNewModifier(
			caster, -- player source
			self,--self:GetAbility(), -- ability source
			"modifier_razor_bryans_breath_lua", -- modifier name
			{ duration = duration } -- kv
		)
    end

    self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Effects
function razor_bryans_breath_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_viper/viper_nethertoxin_impact_vibe.vpcf"
	local sound_cast = "Hero_Viper.Nethertoxin.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetOrigin() )
	--ParticleManager:SetParticleControl( effect_cast, 1, Vector( self:GetSpecialValueFor("radius"), 1, 1 ) )
	--local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end