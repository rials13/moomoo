item_moo_moo_axe_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_moo_moo_axe_modifier:IsHidden()
	return true
end

function item_moo_moo_axe_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function item_moo_moo_axe_modifier:OnCreated( kv )
	-- references
	self.bash_damage = self:GetAbility():GetSpecialValueFor( "bash_damage" )
	self.bash_chance = self:GetAbility():GetSpecialValueFor( "bash_chance" )
	self.bash_duration = self:GetAbility():GetSpecialValueFor( "bash_duration" )
	self.all_stats = self:GetAbility():GetSpecialValueFor( "all_stats" )
end

function item_moo_moo_axe_modifier:OnRefresh( kv )
	-- references
	self:OnCreated( kv )
end

function item_moo_moo_axe_modifier:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_moo_moo_axe_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

function item_moo_moo_axe_modifier:GetModifierBonusStats_Strength( params )
	return self.all_stats
end

function item_moo_moo_axe_modifier:GetModifierBonusStats_Agility( params )
	return self.all_stats
end

function item_moo_moo_axe_modifier:GetModifierBonusStats_Intellect( params )
	return self.all_stats
end

function item_moo_moo_axe_modifier:GetModifierProcAttack_BonusDamage_Physical( params )
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

		if self:RollChance( self.bash_chance ) then
			self.record = params.record
			return self.bash_damage
		end
	end
end

function item_moo_moo_axe_modifier:GetModifierProcAttack_Feedback( params )
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
function item_moo_moo_axe_modifier:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end