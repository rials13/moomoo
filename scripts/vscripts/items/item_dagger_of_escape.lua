item_dagger_of_escape = class({})

--------------------------------------------------------------------------------


function item_dagger_of_escape:OnSpellStart()
    -- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- load data
	local range = self:GetSpecialValueFor("range")
    local over_range = self:GetSpecialValueFor("over_range")

	-- determine target position
	local direction = (point - origin)
	if direction:Length2D() > range then
		point = origin + direction:Normalized() * over_range
	end

    --We disjoint disjointable incoming projectiles.
    ProjectileManager:ProjectileDodge(caster)

	-- teleport
	FindClearSpaceForUnit( caster, point, false )

	-- Play effects
    self:PlayEffects( origin, direction )
end

--------------------------------------------------------------------------------
function item_dagger_of_escape:PlayEffects( origin, direction )
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