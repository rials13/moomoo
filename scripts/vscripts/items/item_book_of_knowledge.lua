item_book_of_knowledge = class({})
LinkLuaModifier( "item_book_of_knowledge_modifier", "items/item_book_of_knowledge_modifier", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifiers
function item_book_of_knowledge:GetIntrinsicModifierName()
    return "item_book_of_knowledge_modifier"
end