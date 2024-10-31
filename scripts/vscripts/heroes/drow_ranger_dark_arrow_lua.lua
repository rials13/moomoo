drow_ranger_dark_arrow_lua = class({})
--LinkLuaModifier( "modifier_drow_ranger_dark_arrow_lua", "heroes/modifierdrow_ranger_dark_arrow_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_orb_effect_lua", "modifier_generic_orb_effect_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function drow_ranger_dark_arrow_lua:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end


--------------------------------------------------------------------------------
-- Ability Start
function drow_ranger_dark_arrow_lua:OnSpellStart()
end

function drow_ranger_dark_arrow_lua:GetProjectileName()
	return "particles/units/heroes/hero_enchantress/enchantress_impetus.vpcf"
end

--------------------------------------------------------------------------------
-- Orb Effects
function drow_ranger_dark_arrow_lua:OnOrbFire( params )
	-- play effects
	local sound_cast = "Hero_Enchantress.Impetus"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function drow_ranger_dark_arrow_lua:OnOrbImpact( params )
	-- unit identifier
	local caster = self:GetCaster()
	local target = params.target

	-- load data
	local damage = self:GetSpecialValueFor("damage")
    local pct_chance = self:GetSpecialValueFor("pct_chance")
    local gold_factor = self:GetSpecialValueFor("gold_factor")

    -- roll for proc
	local roll = RandomInt(1,100)
		if roll <= pct_chance then
			print("Proc midas effect")
			local bounty = target:GetGoldBounty() * gold_factor / 100
			caster:ModifyGold(bounty, true, DOTA_ModifyGold_CreepKill )  --Give the player a flat amount of reliable gold.
			caster:AddExperience(target:GetDeathXP(), DOTA_ModifyXP_CreepKill, true, true)

			--Start the particle and sound.
			target:EmitSound("DOTA_Item.Hand_Of_Midas")
			local midas_particle = ParticleManager:CreateParticle("particles/items2_fx/hand_of_midas.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
			ParticleManager:SetParticleControlEnt(midas_particle, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), false)

			--Remove default gold/XP on the creep before killing it so the caster does not receive anything more.
			target:SetDeathXP(0)
			target:SetMinimumGoldBounty(0)
			target:SetMaximumGoldBounty(0)
			target:Kill(nil, caster) --Kill the creep.  This increments the caster's last hit counter.
		
		-- if the proc fails, we can do damage
		else
			-- apply damage
			local damageTable = {
			victim = target,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = self, --Optional.
			}
			ApplyDamage(damageTable)

			-- play effects
			local sound_cast = "Hero_Enchantress.ImpetusDamage"
			EmitSoundOn( sound_cast, target )
		end


	
end