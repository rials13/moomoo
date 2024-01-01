item_ballista_wc_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_ballista_wc_modifier:IsHidden()
	return false
end

function item_ballista_wc_modifier:IsDebuff()
	return false
end

function item_ballista_wc_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function item_ballista_wc_modifier:IsAura()
	return true
end

function item_ballista_wc_modifier:GetModifierAura()
    if self.is_ranged == true then
        return "item_ballista_wc_modifier_aura_melee"
	elseif self.is_ranged == false then
        return "item_ballista_wc_modifier_aura_ranged"
    else
        return 0 -- none
    end
	--return "item_ballista_wc_modifier_aura"
end

function item_ballista_wc_modifier:GetAuraRadius()
	return self.radius
end

function item_ballista_wc_modifier:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function item_ballista_wc_modifier:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function item_ballista_wc_modifier:GetAuraSearchFlags()
    if self.is_ranged == true then
        return 4 -- only boost damage to melee units
	elseif self.is_ranged == false then
        return 2  -- only boost damage to ranged units
    else
        return 0 -- none
    end
end

function item_ballista_wc_modifier:GetAuraDuration()
	return 0.5 -- stickiness: default 0.5
end
--------------------------------------------------------------------------------
-- Initializations
function item_ballista_wc_modifier:OnCreated( kv )
	-- references
	self.damage_pct_range = self:GetAbility():GetSpecialValueFor( "damage_pct_range" )
	self.damage_pct_melee = self:GetAbility():GetSpecialValueFor( "damage_pct_melee" )
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.crit_damage_mult = self:GetAbility():GetSpecialValueFor( "crit_damage_mult" )
	self.bonus_damage_chance = self:GetAbility():GetSpecialValueFor( "bonus_damage_chance" )
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

    self.is_ranged = self:GetParent():IsRangedAttacker()

    if self.is_ranged == true then
        self.damage_pct = self.damage_pct_range
		self.aura_damage_tooltip = self.damage_pct_melee
		self.aura_damage_tooltip2 = "Melee"
    elseif self.is_ranged == false then
        self.damage_pct = self.damage_pct_melee
		self.aura_damage_tooltip = self.damage_pct_range
		self.aura_damage_tooltip2 = "Ranged"
    end
end

function item_ballista_wc_modifier:OnRefresh( kv )
    self:OnCreated( kv )
end

function item_ballista_wc_modifier:OnDestroy( kv ) end
--------------------------------------------------------------------------------
-- Modifier Effects
function item_ballista_wc_modifier:DeclareFunctions()
	local funcs = {
		--MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        --MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		--MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE_UNIQUE,
        -- bonus damage
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
        -- crit
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
        -- crit sounds
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,

		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}

	return funcs
end

function item_ballista_wc_modifier:GetModifierBaseDamageOutgoing_Percentage( params )
    return self.damage_pct
end

function item_ballista_wc_modifier:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		-- fail if target is invalid
		if params.target:IsBuilding() or params.target:IsOther() then
			return 0
		end
		-- fail if status is invalid
		if self:GetParent():IsIllusion() then
			return 0
		end
		-- Roll for bonus damage
		if self:RollChance( self.bonus_damage_chance ) then
            print("Ballista bonus damage proc: ", self.bonus_damage)
			return self.bonus_damage
		end
	end
end

function item_ballista_wc_modifier:GetModifierPreAttack_CriticalStrike( params )
	if IsServer() then
		if self:RollChance( self.crit_chance ) then
			self.record = params.record
			return self.crit_damage_mult
		end
	end
end

function item_ballista_wc_modifier:OnTooltip()
	return self.aura_damage_tooltip
end

function item_ballista_wc_modifier:OnTooltip2()
	return self.aura_damage_tooltip2
end
--------------------------------------------------------------------------------
-- Graphics & Animations
function item_ballista_wc_modifier:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		if self.record and self.record == params.record then
			self.record = nil

			-- Play effects
			local sound_cast = "Hero_Juggernaut.BladeDance"
			EmitSoundOn( sound_cast, params.target )
		end
	end
end

--------------------------------------------------------------------------------
-- Helper
function item_ballista_wc_modifier:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end