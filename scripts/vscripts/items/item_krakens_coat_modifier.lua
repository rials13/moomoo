item_krakens_coat_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_krakens_coat_modifier:IsHidden()
	return true
end

function item_krakens_coat_modifier:IsDebuff()
	return false
end

function item_krakens_coat_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_krakens_coat_modifier:OnCreated( kv )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.armor = self:GetAbility():GetSpecialValueFor( "armor" )
	self.damage_return_pct = self:GetAbility():GetSpecialValueFor( "damage_return_pct" )
	self.armor_outside = self:GetAbility():GetSpecialValueFor( "armor_outside" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.min_radius = self:GetAbility():GetSpecialValueFor( "min_radius" )
	self.delta = self.radius - self.min_radius

	self.parent = self:GetParent()
	
end

function item_krakens_coat_modifier:OnRefresh( kv )
	self:OnCreated(kv)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_krakens_coat_modifier:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_EVENT_ON_ATTACK_LANDED,

	}

	return funcs
end

function item_krakens_coat_modifier:GetModifierPreAttack_BonusDamage( params )
	return self.damage
end

function item_krakens_coat_modifier:GetModifierPhysicalArmorBonus( params )
	return self.armor
end

function item_krakens_coat_modifier:OnAttackLanded( params )
	if not IsServer() then return end
	if self:GetParent():IsIllusion() or self:GetParent():PassivesDisabled() then return end
	if params.target~=self:GetParent() then return end
	if params.attacker:GetTeamNumber()==params.target:GetTeamNumber() then return end
	if params.attacker:IsOther() or params.attacker:IsBuilding() then return end

	-- Apply Damage
	local damageTable = {
		victim = params.attacker,
		attacker = self:GetParent(),
		damage = params.damage * self.damage_return_pct / 100,
		damage_type = params.damage_type, --DAMAGE_TYPE_PHYSICAL,
		damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
		--ability = self:GetAbility(), --Optional.
	}
	ApplyDamage(damageTable)
	print("returning damage:"..damageTable.damage , damageTable.victim)

	self:PlayEffects( params.attacker )

end

-- Helper: Flag operations
function item_krakens_coat_modifier:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end
--------------------------------------------------------------------------------
-- Graphics & Animations
function item_krakens_coat_modifier:PlayEffects( target )
	local particle_cast = "particles/units/heroes/hero_centaur/centaur_return.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetOrigin(), -- unknown
		true -- unknown, true
	)
end










