ox_inventory = exports.ox_inventory

Callback = {}
local registeredCallbacks = {}

Callback.registerServerCallback = function(name, event)
    if registeredCallbacks[name] then
        print('Ce callback déjà enregistré ! ('..name..')')
    else
        registeredCallbacks[name] = event
    end
end

Callback.registerServerCallback('fk_trash:getItems', function(source)
    local _src = source 
    local items = nil
    items = getItemList()
    while items == nil do
        Wait(100)
    end
	return {items}
end)

RegisterCommand('fk_trash', function(source)
    local xPlayer = getPlayerFromId(source)

    local trash = ox_inventory:CreateTemporaryStash({
        label = Stash.Label,
        slots = Stash.Slots,
        maxWeight = Stash.MaxWeight,
        items = {}
    })

    if xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "help" then
        TriggerClientEvent('fk_trash:openStash', source, 'stash', trash)
    else
        TriggerClientEvent('esx:showNotification', source, "Vous n'êtes pas autorisé à faire cela !", 'info', time)
    end

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            local ItemList = getItemList()
            for _, itemName in ipairs(ItemList) do
                local count = ox_inventory:GetItem(trash, itemName, nil, true)
                if count > 0 then
                    ox_inventory:RemoveItem(trash, itemName, count)
                end
            end
        end
    end)
end)