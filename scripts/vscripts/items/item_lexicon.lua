item_lexicon = class({})
LinkLuaModifier( "item_lexicon_modifier", "items/item_lexicon_modifier", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function item_lexicon:GetIntrinsicModifierName()
	return "item_lexicon_modifier"
end

--------------------------------------------------------------------------------

function item_lexicon:OnSpellStart()
    local hCaster = self:GetCaster()
    local hTarget = self:GetCursorTarget()

    self.xp_multiplier = self:GetSpecialValueFor("xp_multiplier")
    print("on spell start")
    self:Transmute( hCaster, hTarget)
end

function item_lexicon:Transmute( hCaster, hTarget )
    self.bonus_gold = self:GetSpecialValueFor("bonus_gold")
    hCaster:ModifyGold(self.bonus_gold, true, DOTA_ModifyGold_CreepKill )
    hCaster:AddExperience(
        hTarget:GetDeathXP() * self.xp_multiplier, DOTA_ModifyXP_CreepKill, true, true
    )
    print("transmute")
    --Remove default gold/XP on the creep before killing it so the caster does not receive anything more.
	hTarget:SetDeathXP(0)
	hTarget:SetMinimumGoldBounty(0)
    hTarget:SetMaximumGoldBounty(0)
    hTarget:Kill( nil, hCaster) --Kill the creep.  This increments the caster's last hit counter.
    self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Effects
function item_lexicon:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/items2_fx/hand_of_midas.vpcf"
	local sound_cast = "sounds/items/item_handofmidas.vsnd"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCursorTarget() )
    --local effect_cast2 = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 1, self:GetCaster():GetOrigin() )
    --ParticleManager:SetParticleControl( effect_cast1, 1, Vector( self:GetCaster():GetAbsOrigin() ) )
	--ParticleManager:SetParticleControl( effect_cast, 1, Vector( self:GetSpecialValueFor("radius"), 1, 1 ) )
	--local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
    --ParticleManager:ReleaseParticleIndex( effect_cast2 )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end