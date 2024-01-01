modifier_razor_jovans_touch_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_razor_jovans_touch_lua:IsHidden()
	return true
end

function modifier_razor_jovans_touch_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_razor_jovans_touch_lua:OnCreated( kv )
	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" ) -- special value
end

function modifier_razor_jovans_touch_lua:OnRefresh( kv )
	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" ) -- special value	
end

function modifier_razor_jovans_touch_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_razor_jovans_touch_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_razor_jovans_touch_lua:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		-- check break
		if self:GetParent():PassivesDisabled() or self:GetParent():IsIllusion() then return end

		-- check allies
		if params.target:GetTeamNumber()==self:GetParent():GetTeamNumber() then return end

		-- check spell immunity
		if params.target:IsMagicImmune() then return end

		-- check if aerogun is present - the damage from Jovan's Touch is added to Aerogun (in Aerogun mdofifer code)
		if self:GetParent():HasItemInInventory("item_aerogun") then return end
			

		-- add debuff if not present
		local modifier = params.target:FindModifierByNameAndCaster( "modifier_razor_jovans_touch_lua_debuff", self:GetParent() )
		-- original code does nothing if the debuff is applied.
		-- this code refreshes the modifier
		--if not modifier then
			params.target:AddNewModifier(
				self:GetParent(), -- player source
				self:GetAbility(), -- ability source
				"modifier_razor_jovans_touch_lua_debuff", -- modifier name
				{ duration = self.duration } -- kv
			)
		--end
	end
end