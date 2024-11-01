item_sefer_buckler_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function item_sefer_buckler_modifier:IsHidden()
	return true
end

function item_sefer_buckler_modifier:IsDebuff()
	return false
end

function item_sefer_buckler_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function item_sefer_buckler_modifier:OnCreated( kv )
	-- references
	self.damage_block = self:GetAbility():GetSpecialValueFor( "damage_block" )
	self.damage_block_pct = self:GetAbility():GetSpecialValueFor( "damage_block_pct" )
end

function item_sefer_buckler_modifier:OnRefresh( kv )
	-- references
	self:OnCreated( kv )
end

function item_sefer_buckler_modifier:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function item_sefer_buckler_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK
	}

	return funcs
end

function item_sefer_buckler_modifier:GetModifierPhysical_ConstantBlock( params )
	if not IsServer() then return end
	if params.target == self:GetParent() and params.damage_type	== DAMAGE_TYPE_PHYSICAL then
		if params.attacker then
			if RollPercentage(self.damage_block_pct) then
				print("blocking damage " .. self.damage_block .. " of total daamage: " .. params.damage)
				return self.damage_block

			end
		end
	end
end