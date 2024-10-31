--------------------------------------------------------------------------------
modifier_moo_healing_lua_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_moo_healing_lua_effect:IsHidden()
	return true
end

function modifier_moo_healing_lua_effect:IsDebuff()
	return false
end

function modifier_moo_healing_lua_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_moo_healing_lua_effect:OnCreated( kv )
	-- references
	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )
--	self:SetDuration(1.0, false)
	--if self.health_regen < 1 then
	--	self:OnDestroy()
	--end
	--print("Created")
	-- references
	self.health_regen = kv.health_regen
	--self:SetStackCount( self.health_regen )

end

function modifier_moo_healing_lua_effect:OnRefresh( kv )
	if not IsServer() then return end
	-- references
	self.health_regen = kv.health_regen
	--self:SetStackCount( self.health_regen )
	--self:SetDuration(1.0, false)
	--if self.health_regen < 1 then
	--	self:OnDestroy()
	--end
	--print("refreshed")
end

function modifier_moo_healing_lua_effect:OnRemoved()
end

function modifier_moo_healing_lua_effect:OnDestroy()
end
--------------------------------------------------------------------------------
-- Transmitter data
function modifier_moo_healing_lua_effect:AddCustomTransmitterData()
	-- on server
	local data = {
		health_regen = self.health_regen
	
	}

	return data
end

function modifier_moo_healing_lua_effect:HandleCustomTransmitterData( data )
	-- on client
	self.health_regen = data.health_regen
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_moo_healing_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}

	return funcs
end

function modifier_moo_healing_lua_effect:GetModifierConstantHealthRegen()
	return self.health_regen
end