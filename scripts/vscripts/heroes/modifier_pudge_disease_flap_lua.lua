modifier_pudge_disease_flap_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_pudge_disease_flap_lua:IsHidden()
	return false
end

function modifier_pudge_disease_flap_lua:IsDebuff()
	return false
end

function modifier_pudge_disease_flap_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_pudge_disease_flap_lua:OnCreated( kv )
	-- load data
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.dps = self:GetAbility():GetSpecialValueFor( "dps" )
	self.immobile = self:GetAbility():GetSpecialValueFor( "immobile" )
    self.duration = self:GetAbility():GetSpecialValueFor( "duration" )

	if IsServer() then
		-- set seconds counter
		self.sec = 0
		-- precache damage
		self.damageTable = {
			--victim = self:GetParent(), we'll get this OnThink with the finUnitsInRadius
			attacker = self:GetCaster(),
			damage = self.dps,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self, --Optional.
		}
		print("damage: " .. self.dps)

		-- start interval
		self:StartIntervalThink( 1 )
		self:OnIntervalThink()

		-- play effects
		self:PlayEffects1()
        

	end
end

function modifier_pudge_disease_flap_lua:OnRemoved( kv )
	if IsServer() then
		self:StartIntervalThink( -1 )
		self:StopEffects1()
	end
end

function modifier_pudge_disease_flap_lua:OnDestroy( kv )
	if IsServer() then
		self:StartIntervalThink( -1 )
		self:StopEffects1()
	end
end

--------------------------------------------------------------------------------
-- Interval
function modifier_pudge_disease_flap_lua:OnIntervalThink()
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

            -- particles
            local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_pudge/pudge_rot_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy )
			self:AddParticle( nFXIndex, false, false, -1, false, false )
		end

		-- Paly effects?
		print("thinking...")

		-- increment wave
		self.sec = self.sec + 1

        -- Destroy if after duration
        if self.sec>=self.duration then
			self:Destroy()
		end
	end
end

function modifier_pudge_disease_flap_lua:CheckState()
    local state = {}
    if self.sec<=self.immobile then
        state =
	    {
	    	[ MODIFIER_STATE_COMMAND_RESTRICTED ] = true,
	    	[ MODIFIER_STATE_DISARMED ] = true,
	    	[ MODIFIER_STATE_SILENCED ] = true,
	    	[ MODIFIER_STATE_MUTED ] = true,
	    }
    end
    return state
end

--------------------------------------------------------------------------------
-- Effects
function modifier_pudge_disease_flap_lua:PlayEffects1()
	local particle_cast = "particles/units/heroes/hero_pudge/pudge_rot.vpcf"
	self.sound_cast = "Hero_Pudge.Rot"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
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

function modifier_pudge_disease_flap_lua:StopEffects1()
	StopSoundOn( self.sound_cast, self:GetCaster() )
end
