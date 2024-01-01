item_aerogun_modifier_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_aerogun_modifier_debuff:IsHidden()
	return false
end

function item_aerogun_modifier_debuff:IsDebuff()
	return true
end

function item_aerogun_modifier_debuff:IsPurgable()
	return true
end

function item_aerogun_modifier_debuff:DestroyOnExpire()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function item_aerogun_modifier_debuff:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
	self.venom_damage = self:GetAbility():GetSpecialValueFor( "venom_damage" ) -- special value
	self.bonus_gold = self:GetAbility():GetSpecialValueFor( "bonus_gold" ) -- special value

	
	--[[if IsServer() then
		-- Start interval
		self:StartIntervalThink( kv.duration ) -- was passed duration by AddNewModifier
	]]
end

function item_aerogun_modifier_debuff:OnRefresh( kv )
	
end

function item_aerogun_modifier_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_aerogun_modifier_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function item_aerogun_modifier_debuff:OnDeath( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end

		-- check if denied
		if params.unit:GetTeamNumber()==params.attacker:GetTeamNumber() then return end

        --give gold bountybut also check for a real attacker we can give gold to
        if params.attacker:IsRealHero() and not params.attacker:IsSummoned() then
            params.attacker:ModifyGold(self.bonus_gold, true, DOTA_ModifyGold_CreepKill )
            print("gold given from aerogun")
            
             -- check if Razor / Biohazard is the owner of this item, if so adjust damage to compensate for current level of Jovan's Touch
             if params.attacker:FindAbilityByName("razor_jovans_touch_lua") then
                print("hero is razor")
                self.venom_damage = self.venom_damage + params.attacker:FindAbilityByName("razor_jovans_touch_lua"):GetLevelSpecialValueFor("damage", params.attacker:FindAbilityByName("razor_jovans_touch_lua"):GetLevel() - 1)
                print("venom damage" .. self.venom_damage)
             end
        end

		self:Explode( true )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
--[[function item_aerogun_modifier_debuff:OnIntervalThink()
	self:Explode( false )
end]]

--------------------------------------------------------------------------------
-- Helper function
function item_aerogun_modifier_debuff:Explode( death )
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
        dmg = self.venom_damage -- dmg = self.damage_expire
        print("actual damage" .. dmg)
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
function item_aerogun_modifier_debuff:GetEffectName()
	return "particles/units/heroes/hero_sandking/sandking_caustic_finale_debuff.vpcf"
end

function item_aerogun_modifier_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function item_aerogun_modifier_debuff:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_sandking/sandking_caustic_finale_explode.vpcf"
	local sound_cast = "Ability.SandKing_CausticFinale"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end