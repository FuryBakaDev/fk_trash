ESX = exports["es_extended"]:getSharedObject()

function getPlayerFromId(targetId)
    local GetPlayerFromId = ESX.GetPlayerFromId(targetId)
    return GetPlayerFromId
end

function getItemList()
    local items = {}
    
    -- Parcourir la table des items d'ox_inventory
    for name, data in pairs(exports.ox_inventory:Items()) do
        table.insert(items, { name = name, label = data.label })
    end

    return items
end