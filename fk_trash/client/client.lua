ox_inventory = exports.ox_inventory

RegisterNetEvent('fk_trash:openStash', function(stashType, stashData)
        ox_inventory:openInventory(stashType, stashData)
end)