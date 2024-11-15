-- Initialize the tablet UI
RegisterCommand('openBlackTablet', function()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'showTablet' })
end, false)

RegisterNUICallback('closeTablet', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Handle black market interactions
RegisterNUICallback('blackMarket:browse', function(data, cb)
    TriggerServerEvent('blackMarket:getListings')
    cb('ok')
end)

RegisterNUICallback('blackMarket:create', function(data, cb)
    -- Check if the player has the item in their inventory
    local itemData = exports.ox_inventory:GetItem(data.item)
    if itemData and itemData.count >= tonumber(data.quantity) then
        TriggerServerEvent('blackMarket:createListing', data)
        cb({ success = true, message = "Listing created successfully." })
    else
        cb({ success = false, message = "You don't have enough of this item." })
    end
end)

RegisterNUICallback('blackMarket:purchase', function(data, cb)
    TriggerServerEvent('blackMarket:purchaseItem', data.listingId)
    cb('ok')
end)

-- Update client with listings
RegisterNetEvent('blackMarket:sendListings', function(listings)
    SendNUIMessage({ action = 'updateListings', listings = listings })
end)

-- Handle crypto balance display
RegisterNUICallback('crypto:getBalance', function(data, cb)
    TriggerServerEvent('crypto:getBalance')
    cb('ok')
end)

RegisterNetEvent('crypto:receiveBalance', function(balance)
    SendNUIMessage({ action = 'updateBalance', balance = balance })
end)
