if CHoldoutGameMode == nil then
	CHoldoutGameMode = class({})
	_G.CHoldoutGameMode = CHoldoutGameMode
end

require( "holdout_game_round" )
require( "holdout_game_spawner" )
require( "holdout_game_logging" )
require( "holdout_game_ui" )
require( "holdout_game_awards" )

-- game end states
NOT_ENDED = 0
VICTORIOUS = 1
DEFEATED = 2

KILLING_SPREE_KILLS = 100
DOMINATING_KILLS = 200
MEGA_KILL_KILLS = 300
UNSTOPPABLE_KILLS = 400
WICKED_SICK_KILLS = 500
MONSTER_KILL_KILLS = 600
GODLIKE_KILLS = 700
BEYOND_GODLIKE_KILLS = 800

ULTRA_KILL_KILLS = 25
RAMPAGE_KILLS = 50

SPEECH_COOLDOWN = 3.0

-- Precache resources
function Precache( context )
	PrecacheItemByNameSync( "item_tombstone", context )
	PrecacheItemByNameSync( "item_bag_of_gold", context )
	PrecacheItemByNameSync( "item_health_potion", context )
	PrecacheItemByNameSync( "item_mana_potion", context )
	
	PrecacheResource( "model", "models/props_structures/tower_good.vmdl", context )
	PrecacheResource( "particle", "particles/dark_moon/darkmoon_last_hit_effect.vpcf", context )
	PrecacheResource( "particle", "particles/phantom_assassin_linear_dagger.vpcf", context )
	PrecacheResource( "particle", "particles/econ/events/darkmoon_2017/darkmoon_generic_aoe.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_vision.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_thirst_owner.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_gyrocopter/gyro_calldown_marker.vpcf", context )
	PrecacheResource( "particle", "particles/frostivus_gameplay/drow_linear_arrow.vpcf", context ) 
	PrecacheResource( "particle", "particles/frostivus_gameplay/drow_linear_frost_arrow.vpcf", context ) 
	PrecacheResource( "particle", "particles/frostivus_gameplay/legion_gladiators_ring.vpcf", context ) 
	PrecacheResource( "particle", "particles/frostivus_herofx/juggernaut_omnislash_ascension.vpcf", context ) 
	PrecacheResource( "particle", "particles/frostivus_gameplay/holdout_juggernaut_omnislash_image.vpcf", context ) 
	PrecacheResource( "particle", "particles/frostivus_herofx/juggernaut_fs_omnislash_slashers.vpcf", context ) 
	PrecacheResource( "particle", "particles/frostivus_herofx/juggernaut_fs_omnislash_tgt.vpcf", context )

	

	PrecacheResource( "soundfile", "soundevents/game_sounds_new_bloom_2017.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_creeps.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_undying.vsndevts", context )

	-- Tiny's Trample
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_centaur", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_centaur.vsndevts", context )

	-- Round 2
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_dazzle", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dazzle.vsndevts", context )
	PrecacheResource( "particle",  "particles/dark_moon/darkmoon_creep_warning.vpcf", context )

	-- Round 3
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_nyx_assassin", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nyx_assassin.vsndevts", context )

	-- Round 4
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_morphling", context )

	-- Round 5: Bonus

	-- Round 6
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_warlock", context )
	PrecacheResource( "particle_folder", "particles/econ/items/warlock/warlock_staff_hellborn", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_warlock.vsndevts", context )

	-- Round 7
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_undying", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_life_stealer.vsndevts", context )
	PrecacheResource( "model", "models/heroes/undying/undying_minion_torso.vmdl", context )

	-- Round 8
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_tidehunter", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_kunkka", context )
	PrecacheResource( "particle_folder", "particles/econ/items/tidehunter/tidehunter_divinghelmet", context )
	PrecacheResource( "particle_folder", "particles/econ/items/tidehunter/tidehunter_claddish", context )

	-- Round 9
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_batrider", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_batrider.vsndevts", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_meepo", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_meepo.vsndevts", context )
	PrecacheResource( "voicefile", "soundevents/game_sounds_heroes/game_sounds_vo_meepo.vsndevts", context )


	-- Round 10: Bonus
	PrecacheResource( "model", "models/courier/baby_rosh/babyroshan.vmdl", context )

	-- Round 11 
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_night_stalker", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_death_prophet", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_enigma", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_lina/lina_spell_dragon_slave_impact.vpcf", context )

	-- Round 12
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_mirana", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_luna", context )

	-- Round 13
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_alchemist", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_alchemist.vsndevts", context )

	-- Round 14
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_techies", context )
	PrecacheResource( "model", "models/heroes/techies/fx_techiesfx_mine.vmdl", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context )

	-- Round 15
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_invoker", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_doom_bringer", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_ancient_apparition", context )
	PrecacheUnitByNameSync( "npc_dota_creature_invoker_forged_spirit", context, -1 )
	--PrecacheUnitByNameSync( "npc_dota_creature_invoker_forged_spirit", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_invoker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_invoker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ancient_apparition.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_doom_bringer.vsndevts", context )
end

-- Actually make the game mode when we activate
function Activate()
	GameRules.holdOut = CHoldoutGameMode()
	GameRules.holdOut:InitGameMode()

end


function CHoldoutGameMode:InitGameMode()
	self._nRoundNumber = 1
	self._currentRound = nil
	self._flLastThinkGameTime = nil
	self._votes = {}
	self._flEndTime = nil
	self._nGameEndState = NOT_ENDED
	self._nRestartVoteYes = 0
	self._nRestartVoteNo = 0
	self._flGameOverAnimationTimer = 0
	self._bQuit = false
	self._bDisplayingGameEnd = false
	self._flVoteDuration = 1.0 -- we don't use voting right now
	self._bBossHasSpawned = false
	self._bBossHasDied = false
	self._hInvoker = nil
	self.bSetHeroAvailability = false

	self._bFillWithBots = GlobalSys:CommandLineCheck( "-addon_bots" )

	--[[
	self._roundResources = {
		1 = {
			-- no worg precache needed
		},
		2 = {
			PrecacheResource( "particle_folder", "particles/units/heroes/hero_dazzle", context ),
			PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dazzle.vsndevts", context )
		},
		3 = {
			PrecacheResource( "particle_folder", "particles/units/heroes/hero_nyx_assassin", context ),
			PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nyx_assassin.vsndevts", context )
		}
	}
	]]
	
	if self._nAccumulatedPoints == nil then
		self._nAccumulatedPoints = 0
	end

	self._hAncient = Entities:FindByName( nil, "dota_goodguys_fort" )
	if not self._hAncient then
		print( "Ancient entity not found!" )
	end

	GameRules:SetCustomGameSetupTimeout( 0 ) 
	GameRules:SetCustomGameSetupAutoLaunchDelay( 0 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 5 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )
	self._vKillsWithoutDying = {}
	self._wonAwards = {}
	self._lastStreak = {}
	self._killsInWindow = {}
	self._killWindowExpireTime = {}
	self._lastMultiKill = {}

	self:_ReadGameConfiguration()
	
	--GameRules:SetHeroRespawnEnabled( true ) -- allows respawn -- false see OnEntityKilled
	GameRules:SetUseUniversalShopMode( false ) -- shop all shops for everyone
	GameRules:SetHeroSelectionTime( 120.0 )
	GameRules:SetStrategyTime( 0.0 )
	GameRules:SetShowcaseTime( 0.0 )
	GameRules:SetPreGameTime( 15.0 )
	GameRules:SetPostGameTime( 15.0 )
	GameRules:SetTreeRegrowTime( 60.0 )
	GameRules:SetHeroMinimapIconScale( 0.7 )
	GameRules:SetCreepMinimapIconScale( 0.7 )
	GameRules:SetRuneMinimapIconScale( 0.7 )
	--GameRules:SetGoldTickTime( 1 )--/ 60.0 Not working ???? tied to courier?
	--GameRules:SetGoldPerTick( 1 ) -- 0
	GameRules:SetSameHeroSelectionEnabled( true ) --multiple players can pick the same hero
	GameRules:GetGameModeEntity():SetRemoveIllusionsOnDeath( true )
	GameRules:GetGameModeEntity():SetDaynightCycleDisabled( false )
	GameRules:GetGameModeEntity():SetCustomBuybackCostEnabled( true )
	GameRules:SetStartingGold( STARTING_GOLD ) --added bt me for custom start gold
	GameRules:SetTimeOfDay( 0.25 ) -- start game with normal day/night cycle
	

	-- For testing skip ahead to test hero
	--GameRules:GetGameModeEntity():SetCustomGameForceHero("npc_dota_hero_drow_ranger")

	-- Added by me to level up to 50
	GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel( XP_PER_LEVEL_TABLE )
	GameRules:GetGameModeEntity():SetUseCustomHeroLevels( true )
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel( 50 )

	
	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
		PlayerResource:SetCustomTeamAssignment( nPlayerID, DOTA_TEAM_GOODGUYS )
		self._vKillsWithoutDying[ nPlayerID ] = 0
		self._wonAwards[ nPlayerID ] = {}
		self._lastStreak[ nPlayerID ] = 0
		self._killsInWindow[ nPlayerID ] = 0
		self._killWindowExpireTime[ nPlayerID ] = 0
		self._lastMultiKill[ nPlayerID ] = 0 
		
	end

	-- Custom console commands
	Convars:RegisterCommand( "holdout_test_round", function(...) return self:_TestRoundConsoleCommand( ... ) end, "Test a round of holdout.", FCVAR_CHEAT )
	Convars:RegisterCommand( "holdout_spawn_gold", function(...) return self._GoldDropConsoleCommand( ... ) end, "Spawn a gold bag.", FCVAR_CHEAT )
	Convars:RegisterCommand( "holdout_status_report", function(...) return self:_StatusReportConsoleCommand( ... ) end, "Report the status of the current holdout game.", FCVAR_CHEAT )
	
	-- Set all towers invulnerable
	for _, tower in pairs( Entities:FindAllByName( "npc_dota_holdout_tower_spawn_protection" ) ) do
		tower:AddNewModifier( tower, nil, "modifier_invulnerable", {} )
	end

	for _, shrine in pairs( Entities:FindAllByClassname( "npc_dota_healer" ) ) do
		print( "Setting respawn flag on shrine" )
		shrine:SetUnitCanRespawn( true )

		local hAbilitySanctuary = shrine:FindAbilityByName( "filler_ability" )
		if hAbilitySanctuary then
			print( "Found" )
			hAbilitySanctuary:EndCooldown()
		end
	end

	-- Hook into game events allowing reload of functions at run time
	ListenToGameEvent( "npc_spawned", Dynamic_Wrap( CHoldoutGameMode, "OnNPCSpawned" ), self )
	ListenToGameEvent( "player_reconnected", Dynamic_Wrap( CHoldoutGameMode, 'OnPlayerReconnected' ), self )
	ListenToGameEvent( "entity_killed", Dynamic_Wrap( CHoldoutGameMode, 'OnEntityKilled' ), self )
	ListenToGameEvent( "game_rules_state_change", Dynamic_Wrap( CHoldoutGameMode, "OnGameRulesStateChange" ), self )
	ListenToGameEvent( "player_chat", Dynamic_Wrap( CHoldoutGameMode, "OnPlayerChat" ), self )

	-- Added by me: Listen to a player levelup so we can adjust Ability Points for 50 levels
	ListenToGameEvent( "dota_player_gained_level", Dynamic_Wrap(CHoldoutGameMode, "PlayerGainedLevel" ), self)
	ListenToGameEvent( "dota_hero_inventory_item_change", Dynamic_Wrap(CHoldoutGameMode, "InventoryItemChanged" ), self )
	ListenToGameEvent( "dota_hero_entered_shop", Dynamic_Wrap(CHoldoutGameMode, "EnteredShop" ), self)


	-- make some variables as global trackers for secret item creation
	self.moo_tshirt_made = false
	self.moo_moo_tshirt_made = false

	-- Secret Place:
	self.secret_place_found = false
	-- Moo Axe
	self.moo_axe_made = false
	self.nPlayerID0_can_make = false
	self.nPlayerID1_can_make = false
	self.nPlayerID2_can_make = false
	self.nPlayerID3_can_make = false
	self.nPlayerID4_can_make = false
	self.moo_moo_axe_made = false

	CustomGameEventManager:RegisterListener( "vote_button_clicked", function(...) return self:_ProcessVoteButtonClick( ... ) end )

	-- Register OnThink with the game engine so it is called every 0.25 seconds
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, 0.25 ) 
end


-- Read and assign configurable keyvalues if applicable
function CHoldoutGameMode:_ReadGameConfiguration()
	local kv = LoadKeyValues( "scripts/maps/" .. GetMapName() .. ".txt" )
	kv = kv or {} -- Handle the case where there is not keyvalues file

	self._bRestoreHPAfterRound = kv.RestoreHPAfterRound or false
	self._bRestoreMPAfterRound = kv.RestoreMPAfterRound or false
	self._bRewardForTowersStanding = kv.RewardForTowersStanding or false

	self._nTowerRewardAmount = tonumber( kv.TowerRewardAmount or 0 )
	self._nTowerScalingRewardPerRound = tonumber( kv.TowerScalingRewardPerRound or 0 )

	self._flPrepTimeBetweenRounds = tonumber( kv.PrepTimeBetweenRounds or 0 )
	self._flItemExpireTime = tonumber( kv.ItemExpireTime or 10.0 )

	--TODO:
	-- add tick gold here for easy change and put in map file 
	-- add all heroes base gold for creep killed 

	self:_ReadRandomSpawnsConfiguration( kv["RandomSpawns"] )
	self:_ReadLootItemDropsConfiguration( kv["ItemDrops"] )
	self:_ReadRoundConfigurations( kv )
end


-- Verify spawners if random is set
function CHoldoutGameMode:ChooseRandomSpawnInfo()
	if #self._vRandomSpawnsList == 0 then
		error( "Attempt to choose a random spawn, but no random spawns are specified in the data." )
		return nil
	end
	return self._vRandomSpawnsList[ RandomInt( 1, #self._vRandomSpawnsList ) ]
end


-- Verify valid spawns are defined and build a table with them from the keyvalues file
function CHoldoutGameMode:_ReadRandomSpawnsConfiguration( kvSpawns )
	self._vRandomSpawnsList = {}
	if type( kvSpawns ) ~= "table" then
		return
	end
	for _,sp in pairs( kvSpawns ) do			-- Note "_" used as a shortcut to create a temporary throwaway variable
		table.insert( self._vRandomSpawnsList, {
			szSpawnerName = sp.SpawnerName or "",
			szFirstWaypoint = sp.Waypoint or ""
		} )
	end
end


-- If random drops are defined read in that data
function CHoldoutGameMode:_ReadLootItemDropsConfiguration( kvLootDrops )
	self._vLootItemDropsList = {}
	if type( kvLootDrops ) ~= "table" then
		return
	end
	for _,lootItem in pairs( kvLootDrops ) do
		table.insert( self._vLootItemDropsList, {
			szItemName = lootItem.Item or "",
			nChance = tonumber( lootItem.Chance or 0 )
		})
	end
end


-- Set number of rounds without requiring index in text file
function CHoldoutGameMode:_ReadRoundConfigurations( kv )
	self._vRounds = {}
	while true do
		local szRoundName = string.format("Round%d", #self._vRounds + 1 )
		local kvRoundData = kv[ szRoundName ]
		if kvRoundData == nil then
			return
		end
		local roundObj = CHoldoutGameRound()
		roundObj:ReadConfiguration( kvRoundData, self, #self._vRounds + 1 )
		table.insert( self._vRounds, roundObj )
	end
end

--------------------------------------------------------------------------------------------------------

-- When game state changes set state in script
function CHoldoutGameMode:OnGameRulesStateChange()
	local nNewState = GameRules:State_Get()
	if nNewState == DOTA_GAMERULES_STATE_STRATEGY_TIME then
		--Add Instruction Panel call here
		self:ForceAssignHeroes() -- @fixme: this doesn't work
	elseif nNewState == DOTA_GAMERULES_STATE_HERO_SELECTION then
		if self._bFillWithBots == true then
			GameRules:BotPopulate()
		end
	elseif nNewState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		self._flPrepTimeEnd = GameRules:GetGameTime() + self._flPrepTimeBetweenRounds
	end
end

--------------------------------------------------------------------------------------------------------

function CHoldoutGameMode:ForceAssignHeroes()
	print( "ForceAssignHeroes()" )
	for nPlayerID = 0, ( DOTA_MAX_TEAM_PLAYERS - 1 ) do
		if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS then
			local hPlayer = PlayerResource:GetPlayer( nPlayerID )
			if hPlayer and not PlayerResource:HasSelectedHero( nPlayerID ) then
				print( "  Hero selection time is over: forcing nPlayerID " .. nPlayerID .. " to random a hero." )
				hPlayer:MakeRandomHeroSelection()
			end
		end
	end
end

function CHoldoutGameMode:GetAvailableHeroesForMap()
	if (GetMapName() == "classic") or (GetMapName() == "dark_moon") then 
		local tDarkMoonHeroes =
		{
			--"npc_dota_hero_tusk",
			--"npc_dota_hero_phoenix",
			--"npc_dota_hero_zuus",
			--"npc_dota_hero_gyrocopter",
			--"npc_dota_hero_phantom_assassin",
			--"npc_dota_hero_medusa",
			--"npc_dota_hero_ember_spirit",
			--"npc_dota_hero_tiny",
			--"npc_dota_hero_sniper",
			--"npc_dota_hero_abyssal_underlord",
			--"npc_dota_hero_techies",
			--"npc_dota_hero_dark_seer",
			--"npc_dota_hero_winter_wyvern",
			--"npc_dota_hero_treant",
			--"npc_dota_hero_disruptor",
			"npc_dota_hero_life_stealer",
			"npc_dota_hero_razor",
			"npc_dota_hero_lion",
			"npc_dota_hero_drow_ranger",
			"npc_dota_hero_pudge",
			--"npc_dota_hero_cannibal"
		}
		return tDarkMoonHeroes
	end

	return nil
end

--------------------------------------------------------------------------------

function CHoldoutGameMode:SetHeroAvailability()
	print( "SetHeroAvailability" )
	local tHeroes = self:GetAvailableHeroesForMap()
	if tHeroes == nil then 
		GameRules:GetGameModeEntity():SetPlayerHeroAvailabilityFiltered( false )
		return 
	end

	GameRules:GetGameModeEntity():SetPlayerHeroAvailabilityFiltered( true )

	for nPlayerID = 0, 5 - 1 do
		for _,szHeroName in pairs ( tHeroes ) do 
			print( "Adding hero " .. szHeroName .. " for picking" )
			GameRules:AddHeroToPlayerAvailability( nPlayerID, DOTAGameManager:GetHeroIDByName( szHeroName ) )
		end
	end
end

--------------------------------------------------------------------------------------------------------

-- Evaluate the state of the game
function CHoldoutGameMode:OnThink()
	self:_SendRoundDataToClient()

	if GameRules:IsDaytime() then
		-- do this here because it doesn't work in Init
		--GameRules:SetTimeOfDay( 0.751 )
		
	end

	if GameRules:State_Get() == DOTA_GAMERULES_STATE_HERO_SELECTION then
		if self.bSetHeroAvailability ~= true then
			self:SetHeroAvailability()
			self.bSetHeroAvailability = true
		end
	elseif GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		self:_CheckForDefeat()
		self:_ThinkLootExpiry()

		-- added by me for tick gold
		
			if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
				if GameRules:IsGamePaused() == false then
					for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
						if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS then
							if PlayerResource:HasSelectedHero( nPlayerID ) then
								local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID )
								hero.ModifyGold( hero, 1, false, 10) -- gold amount, reliable or not, reason: GAME_TICK = 10
							end
						end
					end
				else end			
			end

		-- 

		if self._flPrepTimeEnd ~= nil then
			self:_ThinkPrepTime()
		elseif self._currentRound ~= nil then
			self._currentRound:Think()
			if self._currentRound:IsFinished() then
				self:_RoundFinished()
			end
		end
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then		-- Safe guard catching any state that may exist beyond DOTA_GAMERULES_STATE_POST_GAME
		return nil
	end
	return 1
end

function CHoldoutGameMode:_RoundFinished()
	self:_AwardPoints( self._currentRound:GetPointReward() )
	self._currentRound:End( true )

	self._currentRound = nil

	
	if (GetMapName() == "dark_moon") then
		-- Heal all players but not on classic
		self:_RefreshPlayers()
			-- Heal ancient
		self._hAncient:SetHealth( self._hAncient:GetMaxHealth() )
		--self._hAncient:SetInvulnCount( self.nAncientInvulnerabilityCount )
	end

	-- Respawn all buildings
	self:_RespawnBuildings()

	if self._nRoundNumber == 9 then
		if Darkness_Thinker then
			print( "Removing Darkness_Thinker" )
			UTIL_Remove( Darkness_Thinker:GetParent() )
		end
	end

	self._nRoundNumber = self._nRoundNumber + 1
	if self._nRoundNumber > #self._vRounds or self:HasBossDied() then
		if self._nGameEndState == NOT_ENDED then
			self:_Victory()
		end
	else
		self._flPrepTimeEnd = GameRules:GetGameTime() + self._flPrepTimeBetweenRounds
	end
end

function CHoldoutGameMode:_RefreshPlayers()
	for nPlayerID = 0, 5 -1 do
		if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS then
			if PlayerResource:HasSelectedHero( nPlayerID ) then
				local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID )
				if not hero:IsAlive() then
					local vLocation = hero:GetOrigin()
					hero:RespawnHero( false, false )
					FindClearSpaceForUnit( hero, vLocation, true )
				end
				hero:SetHealth( hero:GetMaxHealth() )
				hero:SetMana( hero:GetMaxMana() )
			end
		end
	end
end


function CHoldoutGameMode:_RespawnBuildings()
	-- Respawn all the towers.
	self:_PhaseAllUnits( true )
	local buildings = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, Vector( 0, 0, 0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_DEAD, FIND_ANY_ORDER, false )
	for _,building in ipairs( buildings ) do
		if building:IsTower() then
			local sModelName = "models/props_structures/tower_good.vmdl"
			building:SetOriginalModel( sModelName )
			building:SetModel( sModelName )
			local vOrigin = building:GetOrigin()
			if building:IsAlive() then
				building:Heal( building:GetMaxHealth(), building )
			else
				building:RespawnUnit()
			end
			building:SetOrigin( vOrigin )

			if not building:HasAbility( "tower_fortification" ) then building:AddAbility( "tower_fortification" ) end
			local fortificationAbility = building:FindAbilityByName( "tower_fortification" )
			if fortificationAbility then
				fortificationAbility:SetLevel( self._nRoundNumber / 2 )
			end

			building:RemoveModifierByName( "modifier_invulnerable" )
		end

		if building:IsShrine() then
			local sModelName = "models/props_structures/radiant_statue001.vmdl"
			building:SetOriginalModel( sModelName )
			building:SetModel( sModelName )
		
			local vOrigin = building:GetOrigin()
			if building:IsAlive() then
				building:Heal( building:GetMaxHealth(), building )
			else
				building:RespawnUnit()
			end
			building:SetOrigin( vOrigin )

			local hAbilitySanctuary = building:FindAbilityByName( "filler_ability" )
			if hAbilitySanctuary then
				print( "Found" )
				hAbilitySanctuary:EndCooldown()
			end

			building:RemoveModifierByName( "modifier_invulnerable" )
		end
	end
	self:_PhaseAllUnits( false )
end


function CHoldoutGameMode:_PhaseAllUnits( bPhase )
	local units = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, Vector( 0, 0, 0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY + DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_OTHER, 0, FIND_ANY_ORDER, false )
	for _,unit in ipairs(units) do
		if bPhase then
			unit:AddNewModifier( units[i], nil, "modifier_phased", {} )
		else
			unit:RemoveModifierByName( "modifier_phased" )
		end
	end
end


function CHoldoutGameMode:_CheckForDefeat()
	if GameRules:State_Get() ~= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		return
	end

	local bAllPlayersDead = true

	-- added by me for normal moo moo play style (respwan)
	--
	if self._hAncient:IsAlive() then
		bAllPlayersDead = false
	end
	--

	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
		if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS then
			if not PlayerResource:HasSelectedHero( nPlayerID ) then
				bAllPlayersDead = false
			else
				local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID )
				if hero and hero:IsAlive() then
					bAllPlayersDead = false
				end
			end
		end
	end

	if bAllPlayersDead or not self._hAncient or self._hAncient:GetHealth() <= 1 then
		if self._nGameEndState == NOT_ENDED then
			self:_Defeated()
		end
		return
	end
end

function CHoldoutGameMode:_ThinkPrepTime()
	if GameRules:GetGameTime() >= self._flPrepTimeEnd then
		self._flPrepTimeEnd = nil

		if self._nRoundNumber > #self._vRounds then
			GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
			return false
		end

		self._currentRound = self._vRounds[ self._nRoundNumber ]
		self._currentRound:Begin()
		self:_NotifyClientOfRoundStart()
		return
	end

	self._vRounds[ self._nRoundNumber ]:Precache()
end


function CHoldoutGameMode:_ThinkLootExpiry()
	if self._flItemExpireTime <= 0.0 then
		return
	end

	local flCutoffTime = GameRules:GetGameTime() - self._flItemExpireTime

	for _,item in pairs( Entities:FindAllByClassname( "dota_item_drop")) do
		local containedItem = item:GetContainedItem()
		if containedItem:GetAbilityName() == "item_bag_of_gold" or item.Holdout_IsLootDrop then
			self:_ProcessItemForLootExpiry( item, flCutoffTime )
		end
	end
end


function CHoldoutGameMode:_ProcessItemForLootExpiry( item, flCutoffTime )
	if item:IsNull() then
		return false
	end
	if item:GetCreationTime() >= flCutoffTime then
		return true
	end

	local containedItem = item:GetContainedItem()
	if containedItem and containedItem:GetAbilityName() == "item_bag_of_gold" then
		if self._currentRound and self._currentRound.OnGoldBagExpired then
			self._currentRound:OnGoldBagExpired()
		end
	end

	local nFXIndex = ParticleManager:CreateParticle( "particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, item )
	ParticleManager:SetParticleControl( nFXIndex, 0, item:GetOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 35, 35, 25 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )
	local inventoryItem = item:GetContainedItem()
	if inventoryItem then
		UTIL_RemoveImmediate( inventoryItem )
	end
	UTIL_RemoveImmediate( item )
	return false
end


function CHoldoutGameMode:GetDifficultyString()
	local nDifficulty = GameRules:GetCustomGameDifficulty()
	if nDifficulty > 4 then
		return string.format( "(+%d)", nDifficulty )
	elseif nDifficulty > 0 then
		return string.rep( "+", nDifficulty )
	else
		return ""
	end
end

function CHoldoutGameMode:OnNPCSpawned( event )
	local spawnedUnit = EntIndexToHScript( event.entindex )
	if not spawnedUnit or spawnedUnit:GetClassname() == "npc_dota_thinker" or spawnedUnit:IsPhantom() then
		return
	end

	if spawnedUnit:IsCreature() then
		spawnedUnit:SetHPGain( spawnedUnit:GetMaxHealth() * 0.3 ) -- LEVEL SCALING VALUE FOR HP
		spawnedUnit:SetManaGain( 0 )
		spawnedUnit:SetHPRegenGain( 0 )
		spawnedUnit:SetManaRegenGain( 0 )
		if spawnedUnit:IsRangedAttacker() then
			spawnedUnit:SetDamageGain( ( ( spawnedUnit:GetBaseDamageMax() + spawnedUnit:GetBaseDamageMin() ) / 2 ) * 0.1 ) -- LEVEL SCALING VALUE FOR DPS
		else
			spawnedUnit:SetDamageGain( ( ( spawnedUnit:GetBaseDamageMax() + spawnedUnit:GetBaseDamageMin() ) / 2 ) * 0.2 ) -- LEVEL SCALING VALUE FOR DPS
		end
		spawnedUnit:SetArmorGain( 0 )
		spawnedUnit:SetMagicResistanceGain( 0 )
		spawnedUnit:SetDisableResistanceGain( 0 )
		spawnedUnit:SetAttackTimeGain( 0 )
		spawnedUnit:SetMoveSpeedGain( 0 )
		spawnedUnit:SetBountyGain( 0 )
		spawnedUnit:SetXPGain( 0 )
		--spawnedUnit:CreatureLevelUp( GameRules:GetCustomGameDifficulty() )
	end

	if spawnedUnit:IsRealHero() then 
		--spawnedUnit:SetRespawnsDisabled( true )
		if spawnedUnit.bBuybackSet == nil then 
			spawnedUnit.bBuybackSet = true 
			PlayerResource:SetCustomBuybackCost( spawnedUnit:GetPlayerOwnerID(), 150 )
		end
	end
end


function CHoldoutGameMode:OnEntityKilled( event )
	local attackerUnit = EntIndexToHScript( event.entindex_attacker or -1 )
	local killedUnit = EntIndexToHScript( event.entindex_killed )

	if killedUnit and killedUnit:IsRealHero() then
		killedUnit:SetRespawnsDisabled( false )
		-- reset buyback
		killedUnit:SetBuybackCooldownTime( 0 )
		--
		local newItem = CreateItem( "item_tombstone", killedUnit, killedUnit )
		newItem:SetPurchaseTime( 0 )
		newItem:SetPurchaser( killedUnit )
		local tombstone = SpawnEntityFromTableSynchronous( "dota_item_tombstone_drop", {} )
		tombstone:SetContainedItem( newItem )
		tombstone:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
		FindClearSpaceForUnit( tombstone, killedUnit:GetAbsOrigin(), true )	

		self:ResetKillsWithoutDying( killedUnit:GetPlayerOwnerID() )
		if attackerUnit:GetUnitName() == "npc_dota_creature_boss_invoker" then
			self:OnBossKilledPlayer()
		end
	end

	-- lasthit sound and particle
	if killedUnit and killedUnit:IsCreature() then
		if attackerUnit and attackerUnit:IsRealHero() then
			--EmitSoundOnEntityForPlayer( "DarkMoonLastHit", killedUnit, attackerUnit:GetPlayerOwnerID() )
			--ParticleManager:ReleaseParticleIndex( ParticleManager:CreateParticleForPlayer( "particles/dark_moon/darkmoon_last_hit_effect.vpcf", PATTACH_ABSORIGIN_FOLLOW, killedUnit, attackerUnit:GetPlayerOwner() ) )
		end
	end

	if killedUnit:GetUnitName() == "npc_dota_creature_invoker_forged_spirit" then
		if RollPercentage( 5 ) then
			local newItem = CreateItem( "item_health_potion", nil, nil )
			newItem:SetPurchaseTime( 0 )
			if newItem:IsPermanent() and newItem:GetShareability() == ITEM_FULLY_SHAREABLE then
				item:SetStacksWithOtherOwners( true )
			end
			local drop = CreateItemOnPositionSync( killedUnit:GetAbsOrigin(), newItem )
			drop.Holdout_IsLootDrop = true
			
			local dropTarget = killedUnit:GetAbsOrigin() + RandomVector( RandomFloat( 50, 350 ) )
			newItem:LaunchLoot( true, 300, 0.75, dropTarget, nil )
		end
		if RollPercentage( 5 ) then
			local newItem = CreateItem( "item_mana_potion", nil, nil )
			newItem:SetPurchaseTime( 0 )
			if newItem:IsPermanent() and newItem:GetShareability() == ITEM_FULLY_SHAREABLE then
				item:SetStacksWithOtherOwners( true )
			end
			local drop = CreateItemOnPositionSync( killedUnit:GetAbsOrigin(), newItem )
			drop.Holdout_IsLootDrop = true
			
			local dropTarget = killedUnit:GetAbsOrigin() + RandomVector( RandomFloat( 50, 350 ) )
			newItem:LaunchLoot( true, 300, 0.75, dropTarget, nil )
		end
	end

	if killedUnit:GetUnitName() == "npc_dota_creature_boss_invoker" then
		self:_AwardPoints( self._currentRound:GetPointReward() )
		self:_Victory()
	end
end


function CHoldoutGameMode:CheckForLootItemDrop( killedUnit )
	for _,itemDropInfo in pairs( self._vLootItemDropsList ) do
		if RollPercentage( itemDropInfo.nChance ) then
			local newItem = CreateItem( itemDropInfo.szItemName, nil, nil )
			newItem:SetPurchaseTime( 0 )
			if newItem:IsPermanent() and newItem:GetShareability() == ITEM_FULLY_SHAREABLE then
				item:SetStacksWithOtherOwners( true )
			end
			local drop = CreateItemOnPositionSync( killedUnit:GetAbsOrigin(), newItem )
			drop.Holdout_IsLootDrop = true
			if itemDropInfo.szItemName ~= "item_tpscroll" then
				local dropTarget = killedUnit:GetAbsOrigin() + RandomVector( RandomFloat( 50, 350 ) )
				newItem:LaunchLoot( true, 300, 0.75, dropTarget, nil )
			end
		end
	end
end


function CHoldoutGameMode:ComputeTowerBonusGold( nTowersTotal, nTowersStanding )
	local nRewardPerTower = self._nTowerRewardAmount + self._nTowerScalingRewardPerRound * ( self._nRoundNumber - 1 )
	return nRewardPerTower * nTowersStanding
end

-- Leveling/gold data for console command "holdout_test_round"
-- this tables follows warcraft 3 hero leveling == (previous level xp) + (100 * level)
XP_PER_LEVEL_TABLE = {
	0,-- 1
	200,-- 2
	500,-- 3
	900,-- 4
	1400,-- 5
	2000,-- 6
	2600,-- 7
	3200,-- 8
	4400,-- 9
	5400,-- 10
	6000,-- 11
	8200,-- 12
	9000,-- 13
	10400,-- 14
	11900,-- 15
	13500,-- 16
	15200,-- 17
	17000,-- 18
	18900,-- 19
	20900,-- 20
	23000,-- 21
	25200,-- 22
	27500,-- 23
	29900,-- 24
	32400, --25
	35000, --26
	37700, --27
	40500, --28
	43400, --29
	46400, --30
	49500, --31
	52700, --32
	56000, --33
	59400, --34
	62900, --35
	66500, --36
	70200, --37
	74000, --38
	77900, --39
	81900, --40
	86000, --41
	90200, --42
	94500, --43
	98900, --44
	103400, --45
	108000, --46
	112700, --47
	117500, --48
	122400, --49
	127400 --50
}



STARTING_GOLD = 2000
ROUND_EXPECTED_VALUES_TABLE = 
{
	{ gold = STARTING_GOLD, xp = 0 }, -- 1
	{ gold = 1054+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[4] }, -- 2
	{ gold = 2212+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[6] }, -- 3
	{ gold = 3456+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[8] }, -- 4
	{ gold = 4804+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[11] }, -- 5
	{ gold = 6256+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[11] }, -- 6
	{ gold = 7812+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[13] }, -- 7
	{ gold = 9471+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[14] }, -- 8
	{ gold = 11234+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[16] }, -- 9
	{ gold = 13100+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[18] }, -- 10
	{ gold = 15071+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[18] }, -- 11
	{ gold = 17145+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[19] }, -- 12
	{ gold = 19322+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[21] }, -- 13
	{ gold = 21604+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[22] }, -- 14
	{ gold = 23368+STARTING_GOLD, xp = XP_PER_LEVEL_TABLE[24] } -- 15
}

-- sets ability attribute points for extended hero levels
function CHoldoutGameMode:PlayerGainedLevel( event )
	local hero = PlayerResource:GetSelectedHeroEntity( event.PlayerID )
	local level = hero:GetLevel()
	if level == 17 or level == 19 or level >= 21 and level ~= 25 then
		print("special level") -- level 17, 19, 21 - 24, and 26+ do not give ability attribute points. Note: giving 2 points at level 20 for ult
		local unSpentAbility = hero:GetAbilityPoints()
		print(unSpentAbility)
		hero:SetAbilityPoints(unSpentAbility + 1)
	end
	if level == 20 then
		hero:GetAbilityByIndex(6):SetLevel(1)  -- automatically level up the level 20 ability
	end
	print("a player gained a level " .. level)
end

-- listens to inventory contents changing for secret recipies
function CHoldoutGameMode:InventoryItemChanged( event )
	local hero = PlayerResource:GetSelectedHeroEntity( event.player_id )
	if not hero then return end
	--print(hero)
	--print("Inventory Changed")
	local roundNumber = self._nRoundNumber
	--print("Round Number")
	--print(roundNumber)
	local item = EntIndexToHScript( event.item_entindex ):GetName()
	if not item then return end
	--print("item entindex " .. item)
	-- these variables are either nil or 1
	local didSell = event.sold
	--local removed = self.removed
	--local dropped = self.dropped
	--print("Sold:")
	--print(didSell)
	--print("Removed:")
	--print(removed)
	--print("Dropped:")
	--print(dropped)
	
	-- Moo T-shirt logic
	if self.moo_tshirt_made == false then
		if item == "item_mithril_shirt" and didSell == 1 then
			if hero:HasItemInInventory("item_orb_of_fire") and hero:HasItemInInventory("item_orb_of_frost") and hero:HasItemInInventory("item_orb_of_lightning") and hero:HasItemInInventory("item_orb_of_darkness") then
				-- remove four orbs
				hero:RemoveItem( hero:FindItemInInventory("item_orb_of_fire") )
				hero:RemoveItem( hero:FindItemInInventory("item_orb_of_frost") )
				hero:RemoveItem( hero:FindItemInInventory("item_orb_of_lightning") )
				hero:RemoveItem( hero:FindItemInInventory("item_orb_of_darkness") )
				-- add moo t-shirt
				hero:AddItemByName("item_moo_tshirt")
				-- flag that this has been made
				self.moo_tshirt_made = true
				-- send message
				self:SecretMessage( "A Player Dicovered Moo T-shirt!" )
			end
		end
	end
	-- Moo Moo T-shirt logic - Available wave 10 only
	if self.moo_moo_tshirt_made == false and self._nRoundNumber == 10 then
			if item == "item_moo_tshirt" and didSell == 1 then
			if hero:HasItemInInventory("item_orb_of_fire") and hero:HasItemInInventory("item_orb_of_frost") and hero:HasItemInInventory("item_orb_of_lightning") and hero:HasItemInInventory("item_orb_of_darkness") then
				-- remove four orbs
				hero:RemoveItem( hero:FindItemInInventory("item_orb_of_fire") )
				hero:RemoveItem( hero:FindItemInInventory("item_orb_of_frost") )
				hero:RemoveItem( hero:FindItemInInventory("item_orb_of_lightning") )
				hero:RemoveItem( hero:FindItemInInventory("item_orb_of_darkness") )
				-- add moo t-shirt
				hero:AddItemByName("item_moo_moo_tshirt")
				-- flag that this has been made
				self.moo_moo_tshirt_made = true
				-- send message
				self:SecretMessage( "A Player Dicovered Moo Moo T-shirt!" )
			end
		end
	end
	-- halberd
	-- Arcanite
	-- Techtonic
	-- Ragnarock
	-- Book of Knowledge
	-- sadistic
	-- trinity
	-- msytic grallen

	-- secret place
	-- moo axe
	if self.moo_axe_made == false then

		if event.player_id == 0 and self.nPlayerID0_can_make == false then return end
		if event.player_id == 1 and self.nPlayerID1_can_make == false then return end
		if event.player_id == 2 and self.nPlayerID2_can_make == false then return end
		if event.player_id == 3 and self.nPlayerID3_can_make == false then return end
		if event.player_id == 4 and self.nPlayerID4_can_make == false then return end
			
		if item == "item_mattock" and didSell == 1 then
			if hero:HasItemInInventory("item_orb_of_fire") and hero:HasItemInInventory("item_orb_of_frost") and hero:HasItemInInventory("item_orb_of_lightning") and hero:HasItemInInventory("item_orb_of_darkness") then
				-- remove four orbs
				hero:RemoveItem( hero:FindItemInInventory("item_orb_of_fire") )
				hero:RemoveItem( hero:FindItemInInventory("item_orb_of_frost") )
				hero:RemoveItem( hero:FindItemInInventory("item_orb_of_lightning") )
				hero:RemoveItem( hero:FindItemInInventory("item_orb_of_darkness") )
				-- add moo t-shirt
				hero:AddItemByName("item_moo_axe")
				-- flag that this has been made
				self.moo_axe_made = true
				-- send message
				self:SecretMessage( "A Player Dicovered Moo's Axe!" )
			end
		end
	end
	-- Moo Moo Axe logic - Available wave 10 only
	if self.moo_moo_axe_made == false and self._nRoundNumber == 10 then
		if item == "item_moo_axe" and didSell == 1 then
		if hero:HasItemInInventory("item_orb_of_fire") and hero:HasItemInInventory("item_orb_of_frost") and hero:HasItemInInventory("item_orb_of_lightning") and hero:HasItemInInventory("item_orb_of_darkness") then
			-- remove four orbs
			hero:RemoveItem( hero:FindItemInInventory("item_orb_of_fire") )
			hero:RemoveItem( hero:FindItemInInventory("item_orb_of_frost") )
			hero:RemoveItem( hero:FindItemInInventory("item_orb_of_lightning") )
			hero:RemoveItem( hero:FindItemInInventory("item_orb_of_darkness") )
			-- add moo t-shirt
			hero:AddItemByName("item_moo_moo_axe")
			-- flag that this has been made
			self.moo_moo_axe_made = true
			-- send message
			self:SecretMessage( "A Player Dicovered Moo Moo's Axe!" )
		end
	end
end
end

SECRET_PLACE_GOLD = 1000

function CHoldoutGameMode:EnteredShop( event )
	if EntIndexToHScript( event.shop_entindex ):GetName() == "place_secret_shop" then
			--Secret Place Found:
			if self.secret_place_found == false then
				self.secret_place_found = true
				GameRules:SendCustomMessageToTeam( "<font color='#3399EE'>A Player discovered the Secret Place! All player gain " .. SECRET_PLACE_GOLD .. " gold.</font>", DOTA_TEAM_GOODGUYS,0,0)
				-- give gold to all allies
				for nPlayerID = 0, DOTA_MAX_PLAYERS-1 do
					if PlayerResource:IsValidPlayer( nPlayerID ) then
						PlayerResource:ModifyGold( nPlayerID, SECRET_PLACE_GOLD, true, DOTA_ModifyGold_Unspecified  )
					end
				end
			end

			-- Moo Axe Listener
			local player = EntIndexToHScript( event.hero_entindex ):GetPlayerID()
			local hero = PlayerResource:GetSelectedHeroEntity( player )
			if not hero  or not player then end
			if hero:HasItemInInventory("item_orb_of_fire") and hero:HasItemInInventory("item_orb_of_frost") and hero:HasItemInInventory("item_orb_of_lightning") and hero:HasItemInInventory("item_orb_of_darkness") and hero:HasItemInInventory("item_mattock") then
				if player == 0 then
					self.nPlayerID0_can_make = true
				elseif player == 1 then
					self.nPlayerID1_can_make = true
				elseif player == 2 then
					self.nPlayerID2_can_make = true
				elseif player == 3 then
					self.nPlayerID3_can_make = true
				elseif player == 4 then
					self.nPlayerID4_can_make = true
				end
			end
	end
end

function CHoldoutGameMode:SecretMessage( text )
	GameRules:SendCustomMessageToTeam( "<font color='#FF0000'>"  .. text  .. "</font>", DOTA_TEAM_GOODGUYS,0,0)
end

-- Custom game specific console command "holdout_test_round"
function CHoldoutGameMode:_TestRoundConsoleCommand( cmdName, roundNumber, delay )
	local nRoundToTest = tonumber( roundNumber )
	print (string.format( "Testing round %d", nRoundToTest ) )
	if nRoundToTest <= 0 or nRoundToTest > #self._vRounds then
		Msg( string.format( "Cannot test invalid round %d", nRoundToTest ) )
		return
	end

	local nExpectedGold = ROUND_EXPECTED_VALUES_TABLE[nRoundToTest].gold or 600
	local nExpectedXP = ROUND_EXPECTED_VALUES_TABLE[nRoundToTest].xp or 0
	for nPlayerID = 0, DOTA_MAX_PLAYERS-1 do
		if PlayerResource:IsValidPlayer( nPlayerID ) then
			PlayerResource:ReplaceHeroWith( nPlayerID, PlayerResource:GetSelectedHeroName( nPlayerID ), nExpectedGold, nExpectedXP )
			PlayerResource:SetBuybackCooldownTime( nPlayerID, 0 )
			PlayerResource:SetBuybackGoldLimitTime( nPlayerID, 0 )
			PlayerResource:ResetBuybackCostTime( nPlayerID )
			PlayerResource:SetCustomBuybackCost( nPlayerID, ( roundNumber + 1 ) * 150 )
			--hero:SetBuybackCooldownTime( 0 )
		end
	end

	if self._currentRound ~= nil then
		self._currentRound:End()
		self._currentRound = nil
	end

	for _,item in pairs( Entities:FindAllByClassname( "dota_item_drop")) do
		local containedItem = item:GetContainedItem()
		if containedItem then
			UTIL_RemoveImmediate( containedItem )
		end
		UTIL_RemoveImmediate( item )
	end

	if self._hAncient and not self._hAncient:IsNull() then
		self._hAncient:SetHealth( self._hAncient:GetMaxHealth() )
	end

	for i=self._nRoundNumber,nRoundToTest - 1 do
		if self._vRounds[ self._nRoundNumber ]._bUnlockShardAtEnd then
			self:UnlockShard()
		end
	end

	self._flPrepTimeEnd = GameRules:GetGameTime() + self._flPrepTimeBetweenRounds
	self._nRoundNumber = nRoundToTest
	if delay ~= nil then
		self._flPrepTimeEnd = GameRules:GetGameTime() + tonumber( delay )
	end
end

function CHoldoutGameMode:_GoldDropConsoleCommand( cmdName, goldToDrop, nPlayerID )
	local newItem = CreateItem( "item_bag_of_gold", nil, nil )
	newItem:SetPurchaseTime( 0 )
	local origGold = goldToDrop
	if goldToDrop == nil then goldToDrop = 100 end
	print( "Dropping " .. goldToDrop .. " gold. Orig was " .. ( ( origGold == nil and "nil") or origGold ) )
	newItem:SetCurrentCharges( goldToDrop )
	local spawnPoint = Vector( 0, 0, 0 )
	if nPlayerID == nil then
		nPlayerID = 0
	end
	local heroEnt = PlayerResource:GetSelectedHeroEntity( nPlayerID )
	if heroEnt ~= nil then
		spawnPoint = heroEnt:GetAbsOrigin()
	end
	local drop = CreateItemOnPositionSync( spawnPoint, newItem )
	newItem:LaunchLoot( true, 300, 0.75, spawnPoint + RandomVector( RandomFloat( 50, 350 ) ), nil )
end

function CHoldoutGameMode:_StatusReportConsoleCommand( cmdName )
	print( "*** Holdout Status Report ***" )
	print( string.format( "Current Round: %d", self._nRoundNumber ) )
	if self._currentRound then
		self._currentRound:StatusReport()
	end
	print( "*** Holdout Status Report End *** ")
end


function CHoldoutGameMode:_RestartGame()
	-- Clean up the last round
	self._currentRound:End( false )
	self:_RespawnBuildings()
	GameRules:ResetDefeated()
	
	-- Clean up everything on the ground; gold, tombstones, items, everything.
	while GameRules:NumDroppedItems() > 0 do
		local item = GameRules:GetDroppedItem(0)
		UTIL_RemoveImmediate( item )
	end

	
	for playerID=0,4 do
		PlayerResource:SetGold( playerID, STARTING_GOLD, false )
		PlayerResource:SetGold( playerID, 0, true )
		PlayerResource:SetBuybackCooldownTime( playerID, 0 )
		PlayerResource:SetBuybackGoldLimitTime( playerID, 0 )
		PlayerResource:ResetBuybackCostTime( playerID )
	end

	-- Reset values
	self:InitGameMode()

	
	GameRules:ResetToHeroSelection()
	FireGameEvent( "dota_reset_suggested_items", {} )

	-- Reset voting
	self._votes = {}
	self._flEndTime = nil
end

function CHoldoutGameMode:_Defeated()
	GameRules:SetOverlayHealthBarUnit( nil, 0 )
	GameRules:Defeated()

	self._nGameEndState = DEFEATED
	self._flGameOverAnimationTimer = GameRules:GetGameTime() + 0.0
	self:_DisplayGameEnd() 
end

function CHoldoutGameMode:_Victory()
	GameRules:SetOverlayHealthBarUnit( nil, 0 )

	self._nGameEndState = VICTORIOUS
	self._flGameOverAnimationTimer = GameRules:GetGameTime() + 0.0
	self:_DisplayGameEnd()
end


function CHoldoutGameMode:GameOverThink()
	if self._flGameOverAnimationTimer > GameRules:GetGameTime() then
		return 0.25
	end

	self._flGameOverAnimationTimer = 0
	if self._bDisplayingGameEnd == false then
		
		
	end

	return self:_CheckRestartVotes()
end


function CHoldoutGameMode:HasBossSpawned()
	return self._bBossHasSpawned
end


function CHoldoutGameMode:HasBossDied()
	return self._bBossHasDied
end

function CHoldoutGameMode:SpawnBoss()
	self._hInvoker = CreateUnitByName( "npc_dota_creature_boss_invoker", Vector( 1400, -920, 256 ), true, nil, nil, DOTA_TEAM_BADGUYS )
	if self._hInvoker ~= nil then
		self._hInvoker:SetUnitCanRespawn( true )
		self._bBossHasSpawned = true
	end
end

function CHoldoutGameMode:GetPlayerKillsWithoutDying( nPlayerID )
	return self._vKillsWithoutDying[nPlayerID]
end

function CHoldoutGameMode:ResetKillsWithoutDying( nPlayerID )
	local event = 
	{
		gold = 0,
		killer_id = 0,
		killer_streak = 0,
		killer_multikill = 0,
		victim_id = nPlayerID,
		victim_streak = self._lastStreak[nPlayerID] 
	}
	FireGameEvent( "dota_chat_kill_streak", event )

	self._vKillsWithoutDying[nPlayerID] = 0
	self._lastStreak[nPlayerID] = 0	
end

function CHoldoutGameMode:KillsToStreakEnumMap( kills )
	local ret = 0
	if kills >= KILLING_SPREE_KILLS then
		ret = 3
	end
	if kills >= DOMINATING_KILLS then
		ret = 4
	end
	if kills >= MEGA_KILL_KILLS then
		ret = 5
	end
	if kills >= UNSTOPPABLE_KILLS then
		ret = 6
	end
	if kills >= WICKED_SICK_KILLS then
		ret = 7
	end
	if kills >= MONSTER_KILL_KILLS then
		ret = 8
	end
	if kills >= GODLIKE_KILLS then
		ret = 9
	end
	if kills >= BEYOND_GODLIKE_KILLS then
		ret = 10
	end
	return ret
end
 
function CHoldoutGameMode:IncrementKillsWithoutDying( nPlayerID )
	if self._vKillsWithoutDying[nPlayerID] == nil then
		self._vKillsWithoutDying[nPlayerID] = 0
	end
	self._vKillsWithoutDying[nPlayerID] = self._vKillsWithoutDying[nPlayerID] + 1

	local newStreak = self:KillsToStreakEnumMap( self._vKillsWithoutDying[nPlayerID] )
	if newStreak > self._lastStreak[nPlayerID] then
		local event = 
		{
			gold = 0,
			killer_id = nPlayerID,
			killer_streak = newStreak,
			killer_multikill = 0,
		}
		FireGameEvent( "dota_chat_kill_streak", event )

		if newStreak == 3 then
			EmitAnnouncerSound( "announcer_killing_spree_announcer_kill_spree_01" )
		end
		if newStreak == 4 then
			EmitAnnouncerSound( "announcer_killing_spree_announcer_kill_dominate_01" )
		end
		if newStreak == 5 then
			EmitAnnouncerSound( "announcer_killing_spree_announcer_kill_mega_01" )
		end
		if newStreak == 6 then
			EmitAnnouncerSound( "announcer_killing_spree_announcer_kill_unstop_01" )
		end
		if newStreak == 7 then
			EmitAnnouncerSound( "announcer_killing_spree_announcer_kill_wicked_01" )
		end
		if newStreak == 8 then
			EmitAnnouncerSound( "announcer_killing_spree_announcer_kill_monster_01" )
		end
		if newStreak == 9 then
			EmitAnnouncerSound( "announcer_killing_spree_announcer_kill_godlike_01" )
		end
		if newStreak == 10 then
			EmitAnnouncerSound( "announcer_killing_spree_announcer_kill_holy_01" )
		end

		self._lastStreak[nPlayerID] = newStreak
	end
end

function CHoldoutGameMode:AddWonAward( award )
	if award ~= nil then
		local nPlayerID = award["PlayerID"]
		if self._wonAwards[nPlayerID] == nil then
			self._wonAwards[nPlayerID] = {}
		end
		table.insert( self._wonAwards[nPlayerID], award )
	end
end

function CHoldoutGameMode:IncrementKillsInWindow( nPlayerID )
	if self._killsInWindow[nPlayerID] == nil then
		self._killsInWindow[nPlayerID] = 0
	end

	if GameRules:GetGameTime() > self._killWindowExpireTime[nPlayerID] then
		self._killsInWindow[nPlayerID] = 1
		self._killWindowExpireTime[nPlayerID] = GameRules:GetGameTime() + 1.0
		self._lastMultiKill[nPlayerID] = 0
	else
		self._killsInWindow[nPlayerID] = self._killsInWindow[nPlayerID] + 1
		self._killWindowExpireTime[nPlayerID] = GameRules:GetGameTime() + 0.2
	end

	if self._lastMultiKill[nPlayerID] == 0 and self._killsInWindow[nPlayerID] > ULTRA_KILL_KILLS then
		local event = 
		{
			gold = 0,
			killer_id = nPlayerID,
			killer_streak = 0,
			killer_multikill = 4,
		}
		FireGameEvent( "dota_chat_kill_streak", event )
		EmitAnnouncerSound( "announcer_killing_spree_announcer_kill_ultra_01" )
		self._lastMultiKill[nPlayerID] = ULTRA_KILL_KILLS
	end

	if self._lastMultiKill[nPlayerID] == ULTRA_KILL_KILLS and self._killsInWindow[nPlayerID] > RAMPAGE_KILLS then
		local event = 
		{
			gold = 0,
			killer_id = nPlayerID,
			killer_streak = 0,
			killer_multikill = 5,
		}
		FireGameEvent( "dota_chat_kill_streak", event )
		EmitAnnouncerSound( "announcer_killing_spree_announcer_kill_rampage_01" )
		self._lastMultiKill[nPlayerID] = 0
		self._killWindowExpireTime[nPlayerID] = 0
		self._killsInWindow[nPlayerID] = 0
	end
end

function CHoldoutGameMode:GetKillsInWindow( nPlayerID )
	return self._killsInWindow[nPlayerID]
end

function CHoldoutGameMode:OnBossKilledPlayer()
	if self._hInvoker ~= nil then
		if self._hInvoker.flSpeechCooldown > GameRules:GetGameTime() then
			return
		end
		self._hInvoker.flSpeechCooldown = GameRules:GetGameTime() + SPEECH_COOLDOWN
		local nTaunt = RandomInt( 0, 8 )
		if nTaunt == 0 then
			EmitGlobalSound( "invoker_invo_kill_10" )
		end
		if nTaunt == 1 then
			EmitGlobalSound( "invoker_invo_kill_11" )
		end
		if nTaunt == 2 then
			EmitGlobalSound( "invoker_invo_deny_04" )
		end
		if nTaunt == 3 then
			EmitGlobalSound( "invoker_invo_deny_08" )
		end
		if nTaunt == 4 then
			EmitGlobalSound( "invoker_invo_kill_01" )
		end
		if nTaunt == 5 then
			EmitGlobalSound( "invoker_invo_kill_02" )
		end
		if nTaunt == 6 then
			EmitGlobalSound( "invoker_invo_kill_03" )
		end
		if nTaunt == 7 then
			EmitGlobalSound( "invoker_invo_kill_04" )
		end
		if nTaunt == 8 then
			EmitGlobalSound( "invoker_invo_kill_08" )
		end
	end
end

--------------------------------------------------------------------------------
-- player_chat
-- > teamonly - bool
-- > userid - int
-- > playerid - int
-- > text - string
--------------------------------------------------------------------------------

function CHoldoutGameMode:OnPlayerChat( event )
	local nPlayerID = event.playerid
	if nPlayerID == -1 or GameRules:IsDev() == false then
		return
	end

	local sChatMsg = event.text
	if sChatMsg:find( '^-spawn_gold' ) then
		local szStrings = {}
		for s in string.gmatch( sChatMsg, "%S+" ) do
			table.insert( szStrings, s )
		end
		local szArg = szStrings[2]
		if szArg ~= nil then
			self:_GoldDropConsoleCommand( nil, tonumber(szArg), nPlayerID )
		else
			Say( PlayerResource:GetSelectedHeroEntity( nPlayerID ), "Error: amount of gold bags not specified", false )
		end
	elseif sChatMsg:find( '^-test_round' ) then
		local szStrings = {}
		for s in string.gmatch( sChatMsg, "%S+" ) do
			table.insert( szStrings, s )
		end
		local szRound = szStrings[2]
		if szRound == nil then
			Say( PlayerResource:GetSelectedHeroEntity( nPlayerID ), "Error: round not specified", false )
		else
			local szDelay = szStrings[2]
			self:_TestRoundConsoleCommand( nil, tonumber(szRound), szDelay )
		end
	elseif sChatMsg:find( '^-respawn$' ) then
		self:_RefreshPlayers()
	elseif sChatMsg:find( '^-status$' ) then
		self:_StatusReportConsoleCommand( nPlayerID )
	end
end

function CHoldoutGameMode:UnlockShard()
	GameRules:SetItemStockCount( 99, DOTA_TEAM_GOODGUYS, "item_aghanims_shard", -1 )
	local gameEvent = {}
	gameEvent["teamnumber"] = -1
	gameEvent["message"] = "#DOTA_HUD_ShardAvailable"
	FireGameEvent( "dota_combat_event_message", gameEvent )
end