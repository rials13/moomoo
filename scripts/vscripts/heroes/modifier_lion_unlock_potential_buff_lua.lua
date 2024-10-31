modifier_lion_unlock_potential_buff_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lion_unlock_potential_buff_lua:IsHidden()
	return false
end

function modifier_lion_unlock_potential_buff_lua:IsDebuff()
    return false
end

function modifier_lion_unlock_potential_buff_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lion_unlock_potential_buff_lua:OnCreated( kv )
	-- references
	self.chance_proc = self:GetAbility():GetSpecialValueFor( "chance_proc" ) -- special value
    self.bonus_damage_pct = self:GetAbility():GetSpecialValueFor( "bonus_damage_pct" )
    self.hp_regen_pct = self:GetAbility():GetSpecialValueFor( "hp_regen_pct" )
    self.armor = self:GetAbility():GetSpecialValueFor( "armor" )
    self.model_scale = self:GetAbility():GetSpecialValueFor( "model_scale" )

    self.hp_regen = self:GetParent():GetMaxHealth() * self.hp_regen_pct / 100
    print("hp regen:".. self.hp_regen)

    if not IsServer() then return end

	-- play effects
	local sound_cast = "Hero_OgreMagi.Bloodlust.Target"
	EmitSoundOn( sound_cast, self:GetParent() )

	local sound_player = "Hero_OgreMagi.Bloodlust.Target.FP"
	EmitSoundOnClient( sound_player, self:GetParent():GetPlayerOwner() )
end

function modifier_lion_unlock_potential_buff_lua:OnRefresh( kv )
	-- references
	self:OnCreated(kv)	
end

function modifier_lion_unlock_potential_buff_lua:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lion_unlock_potential_buff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,

        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
        MODIFIER_EVENT_ON_ATTACK_FINISHED,
        MODIFIER_PROPERTY_MODEL_SCALE,

        MODIFIER_PROPERTY_TOOLTIP,
	}

	return funcs
end

function modifier_lion_unlock_potential_buff_lua:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_lion_unlock_potential_buff_lua:GetModifierConstantHealthRegen()
	return self.hp_regen
end

function modifier_lion_unlock_potential_buff_lua:GetModifierDamageOutgoing_Percentage()
	return self.bonus_damage_pct
end

function modifier_lion_unlock_potential_buff_lua:GetModifierModelScale()
	return self.model_scale
end

function modifier_lion_unlock_potential_buff_lua:OnTooltip()
	return self.chance_proc
end

function modifier_lion_unlock_potential_buff_lua:OnAttackFinished( params )
	if not IsServer() then return end
    if params.attacker~=self:GetParent() then return end -- make sure the parent is the only thing to trigger the attack

    -- roll chance to proc strength
		local roll = RandomInt(1,100)
		if roll <= self.chance_proc then
			print("chance proc attack")
            self:ResetCooldowns()
		end
end

function modifier_lion_unlock_potential_buff_lua:OnAbilityFullyCast( params )
    if not IsServer() then return end

    -- roll chance to proc strength
		local roll = RandomInt(1,100)
		if roll <= self.chance_proc then
			print("chance proc spell")
            self:ResetCooldowns()
		end
end

function modifier_lion_unlock_potential_buff_lua:ResetCooldowns()
    if IsServer() then
        print("resetiing cooldowns...")
        -- reset cooldowns
        for _ = 0, 20 do
            local ability = self:GetParent():GetAbilityByIndex( _ )
            local item = self:GetParent():GetItemInSlot( _ )
            if ability and (ability:GetCooldownTime() > 0) then
                ability:EndCooldown()
            end
            if item then
                item:EndCooldown()
            end
        end
        -- reset item cooldowns
        --for _ = 0, 5 do
            --local item = self:GetParent():GetItemInSlot( _ )
            --if item then
                --item:EndCooldown()
            --end
        --end
        -- remove buff
        if self:GetParent():HasModifier("modifier_lion_unlock_potential_buff_lua") then
            self:GetParent():RemoveModifierByName("modifier_lion_unlock_potential_buff_lua")
        end
    end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_lion_unlock_potential_buff_lua:GetEffectName()
	return "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf"
end

function modifier_lion_unlock_potential_buff_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end