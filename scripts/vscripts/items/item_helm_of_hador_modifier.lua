item_helm_of_hador_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_helm_of_hador_modifier:IsHidden()
	return true
end

function item_helm_of_hador_modifier:IsDebuff()
	return false
end

function item_helm_of_hador_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function item_helm_of_hador_modifier:OnCreated( kv )
	self.lifesteal_pct = self:GetAbility():GetSpecialValueFor( "lifesteal_pct" )
end

function item_helm_of_hador_modifier:OnRefresh( kv )
	-- references
	self.lifesteal_pct = self:GetAbility():GetSpecialValueFor( "lifesteal_pct" )
end

function item_helm_of_hador_modifier:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_helm_of_hador_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,

	}

	return funcs
end

function item_helm_of_hador_modifier:OnTakeDamage( params )
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end -- if the attacker inst itself
	if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
		
	local heal = params.damage * self.lifesteal_pct / 100
	self:GetParent():Heal( heal, self:GetAbility() )
	self:PlayEffects( self:GetParent() )
	print("helm of hador heals: " .. heal)
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function item_helm_of_hador_modifier:PlayEffects( target )
	-- get resource
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"
	--local sound_cast = "Hero_ChaosKnight.ChaosStrike"

	-- play effects
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- play sound
	--EmitSoundOn( sound_cast, self:GetParent() )
end