item_moo_moo_tshirt_modifier_unleash = class({})
--------------------------------------------------------------------------------
-- Classifications
function item_moo_moo_tshirt_modifier_unleash:IsHidden()
	return false
end

function item_moo_moo_tshirt_modifier_unleash:IsDebuff()
	return false
end

function item_moo_moo_tshirt_modifier_unleash:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function item_moo_moo_tshirt_modifier_unleash:OnCreated( kv )
	-- references
	self.parent = self:GetParent()
	self:PlayEffects(true)



end

function item_moo_moo_tshirt_modifier_unleash:OnRefresh( kv )
	-- references
	self:OnCreated(kv)
end

function item_moo_moo_tshirt_modifier_unleash:OnDestroy( kv )
	self:PlayEffects(false)
end


--------------------------------------------------------------------------------
-- Modifier Effects
function item_moo_moo_tshirt_modifier_unleash:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Status Effects
--[[function item_moo_moo_tshirt_modifier_unleash:CheckState()
	local state = {
	[MODIFIER_STATE_INVULNERABLE ] = true,
	}

	return state
end]]

--no using invulnerable then units wont attack

function item_moo_moo_tshirt_modifier_unleash:GetAbsoluteNoDamagePhysical()
	return 1
end
function item_moo_moo_tshirt_modifier_unleash:GetAbsoluteNoDamageMagical()
	return 1
end
function item_moo_moo_tshirt_modifier_unleash:GetAbsoluteNoDamagePure()
	return 1
end

function item_moo_moo_tshirt_modifier_unleash:PlayEffects( bStart )
	if not IsServer() then return end
	if bStart then
		local particle_cast = "particles/items_fx/glyph_creeps.vpcf"
		self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	else
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end

