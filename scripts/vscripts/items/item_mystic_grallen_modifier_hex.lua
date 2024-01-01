item_mystic_grallen_modifier_hex = class({})
--------------------------------------------------------------------------------
-- Classifications
function item_mystic_grallen_modifier_hex:IsHidden()
	return false
end

function item_mystic_grallen_modifier_hex:IsDebuff()
	return true
end

function item_mystic_grallen_modifier_hex:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function item_mystic_grallen_modifier_hex:OnCreated( kv )
	-- references
	self.move_speed = self:GetAbility():GetSpecialValueFor( "move_speed" )
	self.model = "models/items/hex/sheep_hex/sheep_hex_gold.vmdl"

	if IsServer() then
		-- play effects
		self:PlayEffects( true )

		-- instantly destroy illusions
		if self:GetParent():IsIllusion() then
			self:GetParent():Kill( self:GetAbility(), self:GetCaster() )
		end
	end
end

function item_mystic_grallen_modifier_hex:OnRefresh( kv )
	-- references
	self.move_speed = self:GetAbility():GetSpecialValueFor( "move_speed" )
	if IsServer() then
		-- play effects
		self:PlayEffects( true )
	end
end

function item_mystic_grallen_modifier_hex:OnDestroy( kv )
	if IsServer() then
		-- play effects
		self:PlayEffects( false )
		self:PlayEndEffects()
	end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function item_mystic_grallen_modifier_hex:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}

	return funcs
end

function item_mystic_grallen_modifier_hex:GetModifierMoveSpeedOverride()
	return self.move_speed
end
function item_mystic_grallen_modifier_hex:GetModifierModelChange()
	return self.model
end

--------------------------------------------------------------------------------
-- Status Effects
function item_mystic_grallen_modifier_hex:CheckState()
	local state = {
	[MODIFIER_STATE_HEXED] = true,
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_SILENCED] = true,
	[MODIFIER_STATE_MUTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function item_mystic_grallen_modifier_hex:PlayEffects( bStart )
	local sound_cast = "sounds/misc/morph_in.vsnd"
	local particle_cast = "particles/items_fx/item_sheepstick.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	if bStart then
		EmitSoundOn( sound_cast, self:GetParent() )
	end
end

function item_mystic_grallen_modifier_hex:PlayEndEffects ()
	local sound_cast = "sounds/misc/morph_out.vsnd"
	EmitSoundOn( sound_cast, self:GetParent() )
end