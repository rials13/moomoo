item_trinity = class({})
LinkLuaModifier( "item_trinity_modifier", "items/item_trinity_modifier", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_trinity:GetIntrinsicModifierName()
    return "item_trinity_modifier"
end

-- Projectile
function item_trinity:OnProjectileHit( target, location )
	if not target then return end

	-- perform attack
	self.multi_shot = true
	self:GetCaster():PerformAttack(
		target, -- hTarget
		false, -- bUseCastAttackOrb
		false, -- bProcessProcs
		true, -- bSkipCooldown
		false, -- bIgnoreInvis
		false, -- bUseProjectile
		false, -- bFakeAttack
		false -- bNeverMiss
	)
	self.multi_shot = false
end