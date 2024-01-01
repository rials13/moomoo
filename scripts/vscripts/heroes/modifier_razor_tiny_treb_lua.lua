modifier_razor_tiny_treb_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_razor_tiny_treb_lua:IsHidden()
	return true
end

function modifier_razor_tiny_treb_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
--------------------------------------------------------------------------------
-- get values from special properties
function modifier_razor_tiny_treb_lua:OnCreated( kv )
	self.bonus_agility = self:GetAbility():GetSpecialValueFor( "bonus_agility" )
	self.percent_chance = self:GetAbility():GetSpecialValueFor( "percent_chance" )
    self.skeleton_duration = self:GetAbility():GetSpecialValueFor( "skeleton_duration" )

end

function modifier_razor_tiny_treb_lua:OnRefresh( kv )
	self.bonus_agility = self:GetAbility():GetSpecialValueFor( "bonus_agility" )
	self.percent_chance = self:GetAbility():GetSpecialValueFor( "percent_chance" )
    self.skeleton_duration = self:GetAbility():GetSpecialValueFor( "skeleton_duration" )
end

function modifier_razor_tiny_treb_lua:OnDestroy( kv )
end



--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_razor_tiny_treb_lua:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_EVENT_ON_DEATH

	}

	return funcs
end

function modifier_razor_tiny_treb_lua:GetModifierBonusStats_Agility()
	return self.bonus_agility
end

function modifier_razor_tiny_treb_lua:OnDeath( params )
	if IsServer() then
		if self:GetCaster() == nil then
			return 0
		end

		if self:GetCaster():PassivesDisabled() then
			return 0
		end

		if self:GetCaster() ~= self:GetParent() then
			return 0
		end

		local attacker = params.attacker
		local victim = params.unit
    

		if victim ~= nil and attacker ~= nil and attacker == self:GetCaster() and attacker:GetTeamNumber() ~= victim:GetTeamNumber() then
            -- roll for percent chance to proc
		    local roll = RandomInt(1,100)
		    if roll <= self.percent_chance then
			    print("proc skeleton creation")
			    
                -- create the skeleton
                local skeleton = CreateUnitByName(
                    "npc_dota_dark_troll_warlord_skeleton_warrior", -- unit name from dota_npc_units
                    victim:GetOrigin(), -- v Location
                    true, -- bool find clear space
                    attacker, -- h npc owner
                    attacker, -- h unit owner
                    DOTA_TEAM_GOODGUYS -- int team number
                 
                )
                -- dominate units
		        skeleton:SetControllableByPlayer( self:GetCaster():GetPlayerID(), false ) -- (playerID, bSkipAdjustingPosition)
		        skeleton:SetOwner( self:GetCaster() )

                -- set skeleton duration
				skeleton:AddNewModifier(
					attacker, -- player source
					self:GetAbility(), -- ability source
					"modifier_generic_summon_timer", -- modifier name
					{ duration = self.skeleton_duration } -- kv
                )
                -- set skeleton stats
                skeleton:AddNewModifier(
                    attacker,
                    self:GetAbility(),
                    "modifier_razor_tiny_treb_lua_skeletons",    
                    {}--{ skeleton_life_add = self.skeleton_life_add, skeleton_damage_avg = self.skeleton_damage_avg, skeleton_armor = self.skeleton_armor }
                )

		    end
        end
	end
end
