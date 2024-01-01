item_tectonic_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_tectonic_modifier:IsHidden()
	return true
end

function item_tectonic_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function item_tectonic_modifier:OnCreated( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.bash_damage = self:GetAbility():GetSpecialValueFor( "bash_damage" )
	self.bash_chance_melee = self:GetAbility():GetSpecialValueFor( "bash_chance_melee" )
	self.bash_chance_ranged = self:GetAbility():GetSpecialValueFor( "bash_chance_ranged" )
	self.bash_duration = self:GetAbility():GetSpecialValueFor( "bash_duration" )
	self.agility = self:GetAbility():GetSpecialValueFor( "agility" )
	self.evasion = self:GetAbility():GetSpecialValueFor( "evasion" )
end

function item_tectonic_modifier:OnRefresh( kv )
	-- references
	self:OnCreated( kv )
end

function item_tectonic_modifier:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_tectonic_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

function item_tectonic_modifier:GetModifierPreAttack_BonusDamage( params )
	return self.damage
end

function item_tectonic_modifier:GetModifierBonusStats_Agility( params )
	return self.agility
end

function item_tectonic_modifier:GetModifierEvasion_Constant( params )
	return self.evasion
end



function item_tectonic_modifier:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		-- fail if target is invalid
		if params.target:IsBuilding() or params.target:IsOther() then
			return 0
		end

		-- fail if status is invalid
		if self:GetParent():IsIllusion() then
			return 0
		end

		-- check that this is fully castable (aka: is on cooldown)
		if not self:GetAbility():IsFullyCastable() then return end

		-- check if item owner is melee or ranged
		self.bash_chance = self.bash_chance_melee
		if self:GetParent():IsRangedAttacker() then
			self.bash_chance = self.bash_chance_ranged
		end

		if self:RollChance( self.bash_chance ) then
			self.record = params.record
			return self.bash_damage
		end
	end
end

function item_tectonic_modifier:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		if params.record==self.record then
			-- set duration
			local act_duration = self.bash_duration
			--if params.target:IsHero() then
			--	act_duration = self.duration
			--end

			params.target:AddNewModifier(
				self:GetParent(),
				self:GetAbility(),
				"modifier_generic_bashed_lua",
				{ duration = act_duration }
			)

			-- set cooldown
			self:GetAbility():UseResources( false, false, true ) 

			-- Effects
			EmitSoundOn( "Hero_Slardar.Bash", params.target )
		end
	end
end
--------------------------------------------------------------------------------
-- Graphics & Animations

--------------------------------------------------------------------------------
-- Helper
function item_tectonic_modifier:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end