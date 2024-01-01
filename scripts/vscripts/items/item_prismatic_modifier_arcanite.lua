item_prismatic_modifier_arcanite = class({})
--------------------------------------------------------------------------------
-- Classifications
function item_prismatic_modifier_arcanite:IsHidden()
	return false
end

function item_prismatic_modifier_arcanite:IsDebuff()
	return false
end

function item_prismatic_modifier_arcanite:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function item_prismatic_modifier_arcanite:OnCreated( kv )
	-- references
	self.armor = self:GetAbility():GetSpecialValueFor( "armor" )

	if not IsServer() then return end
	-- full heal
	self:GetParent():SetHealth( self:GetParent():GetMaxHealth() )




	self:PlayEffects()
end

function item_prismatic_modifier_arcanite:OnRefresh( kv )
	-- references
	self.armor = self:GetAbility():GetSpecialValueFor( "armor" )
	
end

function item_prismatic_modifier_arcanite:OnDestroy( kv )
	
end


--------------------------------------------------------------------------------
-- Modifier Effects
function item_prismatic_modifier_arcanite:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE_ACTIVE,
	}

	return funcs
end

function item_prismatic_modifier_arcanite:GetModifierPhysicalArmorBonusUniqueActive()
	return self.armor
end

function item_prismatic_modifier_arcanite:PlayEffects()
	local particle_cast = "particles/items2_fx/mekanism_recipient.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	local sound_cast = "DOTA_Item.Mekansm.Target"
	EmitSoundOn( sound_cast, self:GetParent() )
end
