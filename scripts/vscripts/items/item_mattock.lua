item_mattock = class({})
LinkLuaModifier( "item_mattock_modifier", "items/item_mattock_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_bashed_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_mattock:GetIntrinsicModifierName()
    return "item_mattock_modifier"
end