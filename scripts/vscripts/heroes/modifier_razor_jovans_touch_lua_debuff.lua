modifier_razor_jovans_touch_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_razor_jovans_touch_lua_debuff:IsHidden()
	return false
end

function modifier_razor_jovans_touch_lua_debuff:IsDebuff()
	return true
end

function modifier_razor_jovans_touch_lua_debuff:IsPurgable()
	return true
end

function modifier_razor_jovans_touch_lua_debuff:DestroyOnExpire()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_razor_jovans_touch_lua_debuff:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" ) -- special value
	--self.damage_expire = self:GetAbility():GetSpecialValueFor( "damage_expire" ) -- special value
	
	--if IsServer() then
		-- Start interval
		--self:StartIntervalThink( kv.duration )
	--end
end

function modifier_razor_jovans_touch_lua_debuff:OnRefresh( kv )
	print("refreshed")
end

function modifier_razor_jovans_touch_lua_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_razor_jovans_touch_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_razor_jovans_touch_lua_debuff:OnDeath( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end

		-- check if denied
		if params.unit:GetTeamNumber()==params.attacker:GetTeamNumber() then return end

		self:Explode( true )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
--[[function modifier_razor_jovans_touch_lua_debuff:OnIntervalThink()
	self:Explode( false )
end]]

--------------------------------------------------------------------------------
-- Helper function
function modifier_razor_jovans_touch_lua_debuff:Explode( death )
	-- find enemies
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

	-- precache damage table
	--local dmg = self.damage
    local dmg = 0
	if death then 
        dmg = self.damage -- dmg = self.damage_expire

	    local damageTable = {
		    -- victim = target,
		    attacker = self:GetCaster(),
		    damage = dmg,
		    damage_type = DAMAGE_TYPE_MAGICAL,
		    ability = self:GetAbility(), --Optional.
	    }

	    for _,enemy in pairs(enemies) do
		    -- damage
			if enemy:IsAlive() then
		    	damageTable.victim = enemy
		    	ApplyDamage(damageTable)
			end
	    end

    	-- effects
	    self:PlayEffects()

	    -- destroy
	    self:Destroy()
    end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_razor_jovans_touch_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_sandking/sandking_caustic_finale_debuff.vpcf"
end

function modifier_razor_jovans_touch_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_razor_jovans_touch_lua_debuff:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_sandking/sandking_caustic_finale_explode.vpcf"
	local sound_cast = "Ability.SandKing_CausticFinale"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end