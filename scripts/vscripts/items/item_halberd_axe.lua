item_halberd_axe = class({})
LinkLuaModifier( "item_halberd_axe_modifier", "items/item_halberd_axe_modifier", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_halberd_axe:GetIntrinsicModifierName()
    return "item_halberd_axe_modifier"
end

----------
function item_halberd_axe:OnSpellStart()
    self:SpendCharge()
    local hero = self:GetCaster()
    print(hero)

    -- Create a new empty item
    local newItem = CreateItem( "item_sadistic_axe_helper", nil, nil )
    --newItem:SetPurchaseTime( 0 )

    -- Make a new item and launch it near the hero
    local spawnPoint = Vector( 0, 0, 0 )
    spawnPoint = hero:GetAbsOrigin()
    local drop = CreateItemOnPositionSync( spawnPoint, newItem )
    newItem:LaunchLoot( false, 200, 0.75, spawnPoint + RandomVector( RandomFloat( 50, 150 ) ) )
end