item_sadistic_axe_modifier_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_sadistic_axe_modifier_passive:IsHidden()
	return true
end

function item_sadistic_axe_modifier_passive:IsDebuff()
	return false
end

function item_sadistic_axe_modifier_passive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_sadistic_axe_modifier_passive:OnCreated( kv )
	self.parent = self:GetParent()

	self.agility = self:GetAbility():GetSpecialValueFor( "agility" )
	self.agility_damage_mult = self:GetAbility():GetSpecialValueFor( "agility_damage_mult" )	
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
	self.crit_damage_mult = self:GetAbility():GetSpecialValueFor( "crit_damage_mult" )

		-- precache damage
		self.damageTable = {
			--victim = target,
			attacker = self:GetParent(),
			damage = self:GetParent():GetAgility() * self.agility_damage_mult,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = self:GetAbility(), --Optional.
		}
end

function item_sadistic_axe_modifier_passive:OnRefresh( kv )
	-- references
	self:OnCreated( kv )
end

function item_sadistic_axe_modifier_passive:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_sadistic_axe_modifier_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_EVENT_ON_ATTACK_LANDED,	
	}

	return funcs
end

function item_sadistic_axe_modifier_passive:GetModifierBonusStats_Agility( params )
	return self.agility
end

function item_sadistic_axe_modifier_passive:OnAttackLanded( params )
	if params.attacker~=self.parent then return end
	if IsServer() then
		self.damageTable.victim = params.target
		ApplyDamage(self.damageTable)

		-- overhead event
		SendOverheadEventMessage(
			nil,
			OVERHEAD_ALERT_OUTGOING_DAMAGE,
			self.parent,
			self.damageTable.damage,
			nil
		)
		--print("Agility Damage", self.damageTable.damage)
	end
end

function item_sadistic_axe_modifier_passive:GetModifierPreAttack_CriticalStrike( params )
	if IsServer() then
		if self:RollChance( self.crit_chance ) then
			self.record = params.record
			return self.crit_damage_mult
		end
	end
end

function item_sadistic_axe_modifier_passive:GetModifierProcAttack_Feedback( params )
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
function item_sadistic_axe_modifier_passive:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end