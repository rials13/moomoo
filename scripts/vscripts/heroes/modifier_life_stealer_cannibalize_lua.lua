modifier_life_stealer_cannibalize_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_life_stealer_cannibalize_lua:IsHidden()
	return true
end

function modifier_life_stealer_cannibalize_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_life_stealer_cannibalize_lua:OnCreated( kv )
	self.lifesteal_percent = self:GetAbility():GetSpecialValueFor( "lifesteal_percent" )
end

function modifier_life_stealer_cannibalize_lua:OnRefresh( kv )
	self.lifesteal_percent = self:GetAbility():GetSpecialValueFor( "lifesteal_percent" )
end

function modifier_life_stealer_cannibalize_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_life_stealer_cannibalize_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_life_stealer_cannibalize_lua:OnTakeDamage( params )
	-- logic
	if IsServer() then
		if params.attacker == self:GetParent() and ( not self:GetParent():IsIllusion() ) then -- checks that lifestealer is attacker and not an illusion
			if self:GetParent():PassivesDisabled() then 
				return --prevents lifesteal if passives disabled
			end
			if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
				return
			end
			local heal = params.damage * self.lifesteal_percent / 100
			self:GetParent():Heal( heal, self:GetAbility() )
			self:PlayEffects( self:GetParent() )
			print("lifesteal heals: " .. heal)
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics and Animations
function modifier_life_stealer_cannibalize_lua:PlayEffects()
	-- get resource
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"
	--play effects
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end