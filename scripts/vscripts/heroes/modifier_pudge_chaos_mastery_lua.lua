-- from Atrophy Aura skill

modifier_pudge_chaos_mastery_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_pudge_chaos_mastery_lua:IsHidden()
	return false
end

function modifier_pudge_chaos_mastery_lua:IsDebuff()
	return false
end

function modifier_pudge_chaos_mastery_lua:IsStunDebuff()
	return false
end

function modifier_pudge_chaos_mastery_lua:IsPurgable()
	return false
end

function modifier_pudge_chaos_mastery_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_pudge_chaos_mastery_lua:RemoveOnDeath()
	return false
end

function modifier_pudge_chaos_mastery_lua:DestroyOnExpire()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_pudge_chaos_mastery_lua:OnCreated( kv )
    -- references
	self.kills = self:GetAbility():GetSpecialValueFor( "kills" )
	self.str_per_stack = self:GetAbility():GetSpecialValueFor( "str_per_stack" )
	self.base_damage_pct = self:GetAbility():GetSpecialValueFor( "base_damage_pct" )
	
	if not IsServer() then return end
    

    self.kill_count = 0
    self.stack = 0

    -- credit previous kills
    local prev_kills = self:GetParent():GetLastHits() + self:GetParent():GetKills()
    print("On Created - Pudge Kills " .. prev_kills)
    self.kill_count = prev_kills
    self:SetStackCount( math.floor(self.kill_count / self.kills) )

    -- calculate kills to next stack
    self.stack = self.kills - (self.kill_count - (math.floor(self.kill_count / self.kills) * self.kills))
    print("to next stack " .. self.stack)

    -- add the stack count modifier
    self:GetParent():AddNewModifier(
        self:GetParent(), -- player source
	    self:GetAbility(), -- ability source
	    "modifier_pudge_chaos_mastery_lua_stack", -- modifier name
	    { stack = self.stack } -- kv
	)

end

function modifier_pudge_chaos_mastery_lua:OnRefresh( kv )
    -- references
	self.kills = self:GetAbility():GetSpecialValueFor( "kills" )
	self.str_per_stack = self:GetAbility():GetSpecialValueFor( "str_per_stack" )
	self.base_damage_pct = self:GetAbility():GetSpecialValueFor( "base_damage_pct" )
	
	if not IsServer() then return end
end

function modifier_pudge_chaos_mastery_lua:OnRemoved()
end

function modifier_pudge_chaos_mastery_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_pudge_chaos_mastery_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
		
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,

        MODIFIER_PROPERTY_TOOLTIP,

	}

	return funcs
end

function modifier_pudge_chaos_mastery_lua:OnDeath( params )
	if not IsServer() then return end
	local parent = self:GetParent()

    -- check the attacker is pudge
    if params.attacker ~= parent then return end

	-- cancel if break
	if parent:PassivesDisabled() then return end

	-- not illusion
	if params.unit:IsIllusion() then return end
    
	-- add stack
    
    self.kill_count = self.kill_count + 1
    print("pudge got a kill " .. self.kill_count)
    self:SetStackCount( math.floor(self.kill_count / self.kills) )
    
    --stack count decrement
    self.stack = self.stack - 1
    if self.stack == 0 then
        self.stack = self.kills
    end

    --change buff modifier 
    parent:SetModifierStackCount(
        "modifier_pudge_chaos_mastery_lua_stack", -- modifier name 
        self:GetParent(),
        self.stack
    )

	-- add modifier
	--parent:AddNewModifier(
	--	parent, -- player source
	--	self:GetAbility(), -- ability source
	--	"modifier_pudge_chaos_mastery_lua_stack", -- modifier name
	--	{ str_per_stack = self.str_per_stack } -- kv
	--)
end

function modifier_pudge_chaos_mastery_lua:GetModifierBaseDamageOutgoing_Percentage()
	return self.base_damage_pct
end

function modifier_pudge_chaos_mastery_lua:GetModifierBonusStats_Strength()
    return self:GetStackCount() * self.str_per_stack
end

function modifier_pudge_chaos_mastery_lua:OnTooltip()
    return self:GetStackCount() * self.str_per_stack
end