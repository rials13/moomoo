magroth_immunity_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function magroth_immunity_modifier:IsHidden()
	return true
end

function magroth_immunity_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function magroth_immunity_modifier:OnCreated( kv )
    self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
    --self.damage_percent = self:GetAbility():GetSpecialValueFor( "damage_percent" )
end

function magroth_immunity_modifier:OnRefresh( kv )
    --self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
    --self.damage_percent = self:GetAbility():GetSpecialValueFor( "damage_percent" )
end

function magroth_immunity_modifier:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function magroth_immunity_modifier:DeclareFunctions()
	local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
	}

	return funcs
end

function magroth_immunity_modifier:OnAttackLanded( params )
	if IsServer() then
		--if params.target~=self:GetCaster() then return end
		if self:GetCaster():PassivesDisabled() then return end
		if params.attacker:GetTeamNumber()==params.target:GetTeamNumber() then return end
		if params.attacker:IsOther() or params.attacker:IsBuilding() then return end
		if self:GetAbility():IsCooldownReady()==false then return end
		if params.target==self:GetCaster() or params.attacker==self:GetCaster() then -- if self attacks or is attacked

			self:GetParent():AddNewModifier(
				self:GetParent(), -- player source
				self:GetAbility(), -- ability source
				"magroth_immunity_modifier_effect", -- modifier name
				{ duration = self.duration } -- kv
			)

			-- cooldown
			self:GetAbility():UseResources(false, false, false, true)

			-- Play Effects
			local sound_cast = "Hero_Omniknight.GuardianAngel.Cast"
			EmitSoundOn( sound_cast, self:GetParent() )
		end
	end
end
--------------------------------------------------------------------------------
-- Graphics and Animations