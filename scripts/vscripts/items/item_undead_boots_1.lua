item_undead_boots_1 = class({})
LinkLuaModifier( "item_undead_boots_modifier", "items/item_undead_boots_modifier", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_undead_boots_1:GetIntrinsicModifierName()
    return "item_undead_boots_modifier"
end
--------------------------------------------------------------------------------

function item_undead_boots_1:OnSpellStart()
    -- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- load data

	-- determine target position
	local direction = (point - origin)

    --We disjoint disjointable incoming projectiles.
    ProjectileManager:ProjectileDodge(caster)

	-- teleport
	FindClearSpaceForUnit( caster, origin + direction, true )

	-- Play effects
    self:PlayEffects( origin, direction )
end

--------------------------------------------------------------------------------
function item_undead_boots_1:PlayEffects( origin, direction )
	-- Get Resources
	local particle_cast_a = "particles/items_fx/blink_dagger_start.vpcf"
	local sound_cast_a = "DOTA_Item.BlinkDagger.Activate"

	local particle_cast_b = "particles/items_fx/blink_dagger_end.vpcf" 

	-- At original position
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast_a, 0, origin )
	ParticleManager:SetParticleControlForward( effect_cast_a, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	EmitSoundOnLocationWithCaster( origin, sound_cast_a, self:GetCaster() )

	-- At original position
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast_b, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast_b, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end