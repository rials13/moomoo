item_warclub_2 = class({})
LinkLuaModifier( "item_ballista_wc_modifier", "items/item_ballista_wc_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_ballista_wc_modifier_aura_ranged", "items/item_ballista_wc_modifier_aura_ranged", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_ballista_wc_modifier_aura_melee", "items/item_ballista_wc_modifier_aura_melee", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_warclub_2:GetIntrinsicModifierName()
    return "item_ballista_wc_modifier"
end