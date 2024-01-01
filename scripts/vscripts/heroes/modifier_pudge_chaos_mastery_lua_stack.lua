--------------------------------------------------------------------------------
modifier_pudge_chaos_mastery_lua_stack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_pudge_chaos_mastery_lua_stack:IsHidden()
	return false
end

function modifier_pudge_chaos_mastery_lua_stack:IsDebuff()
	return false
end

function modifier_pudge_chaos_mastery_lua_stack:IsPurgable()
	return false
end

function modifier_pudge_chaos_mastery_lua_stack:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_pudge_chaos_mastery_lua_stack:OnCreated( kv )
	if not IsServer() then return end
	self:SetStackCount( kv.stack )
end

function modifier_pudge_chaos_mastery_lua_stack:OnRefresh( kv )
	if not IsServer() then return end
	self:SetStackCount( kv.stack )
end

function modifier_pudge_chaos_mastery_lua_stack:OnRemoved()
end

function modifier_pudge_chaos_mastery_lua_stack:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_pudge_chaos_mastery_lua_stack:DeclareFunctions()
	local funcs = {

	}

	return funcs
end
