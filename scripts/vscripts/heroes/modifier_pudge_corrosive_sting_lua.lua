modifier_pudge_corrosive_sting_lua = class({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_pudge_corrosive_sting_lua:IsHidden()
	return true
end

function modifier_pudge_corrosive_sting_lua:IsDebuff()
	return false
end

function modifier_pudge_corrosive_sting_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_pudge_corrosive_sting_lua:OnCreated( kv )
	-- references
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.team = self:GetCaster():GetTeamNumber()

	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )

	if not IsServer() then return end
	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()
end

function modifier_pudge_corrosive_sting_lua:OnRefresh( kv )
	-- references
	self:OnCreated( kv )
end

function modifier_pudge_corrosive_sting_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_pudge_corrosive_sting_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end
function modifier_pudge_corrosive_sting_lua:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end
	if self.caster:PassivesDisabled() then return end

	local filter = UnitFilter(
		params.target, -- npc 
		self.abilityTargetTeam, -- team 
		self.abilityTargetType, -- type 
		self.abilityTargetFlags, -- flag
		self.team -- team
	)
	if not filter==UF_SUCCESS then return end
		
	-- Apply debuff to enemy
		params.target:AddNewModifier(
			self.caster, -- player source
			self.ability, -- ability source
			"modifier_pudge_corrosive_sting_lua_debuff", -- modifier name
			{ duration = self.duration } -- kv
		)

		-- Play effects
		--self:PlayEffects( params.target )
end