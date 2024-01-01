item_masktr_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_masktr_modifier:IsHidden()
	return false
end

function item_masktr_modifier:IsDebuff()
	return false
end

function item_masktr_modifier:IsPurgable()
	return false
end
-------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Initializations
function item_masktr_modifier:OnCreated( kv )
	-- references
	self.unholy_lifesteal_pct = self:GetAbility():GetSpecialValueFor( "unholy_lifesteal_pct" )

	if not IsServer() then return end
	-- disjoint & purge
	ProjectileManager:ProjectileDodge( self:GetParent() )
	self:GetParent():Purge( false, true, false, false, false ) -- basic dispel

	self:PlayEffects()
end

function item_masktr_modifier:OnRefresh( kv )
    -- references
	self.unholy_lifesteal_pct = self:GetAbility():GetSpecialValueFor( "unholy_lifesteal_pct" )
end

function item_masktr_modifier:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_masktr_modifier:DeclareFunctions()
	local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_TOOLTIP
	}

	return funcs
end

function item_masktr_modifier:OnTakeDamage( params )
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end -- if the attacker inst itself
	if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
		
	local heal = params.damage * self.unholy_lifesteal_pct / 100
	self:GetParent():Heal( heal, self:GetAbility() )
	--self:PlayEffects( self:GetParent() )
	print("mask tho'roth active lifesteal heals: " .. heal)
end

function item_masktr_modifier:OnTooltip()
	return self.unholy_lifesteal_pct
end

function item_masktr_modifier:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/items2_fx/satanic_buff.vpcf"
	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end