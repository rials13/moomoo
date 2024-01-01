item_mithril_rod = class({})
LinkLuaModifier( "item_mithril_rod_modifier", "items/item_mithril_rod_modifier", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_mithril_rod:GetIntrinsicModifierName()
    return "item_mithril_rod_modifier"
end

-- Projectile
function item_mithril_rod:OnProjectileHit( target, location )
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