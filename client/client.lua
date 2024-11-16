local QBCore = exports['qb-core']:GetCoreObject()

-- Open the tablet UI
RegisterCommand('openBlackTablet', function()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "open" })
end)

-- Close the tablet UI
RegisterNUICallback('closeTablet', function()
    SetNuiFocus(false, false)
end)

-- Update crypto balance
RegisterNetEvent('avid-blacktablet:updateCryptoBalance')
AddEventHandler('avid-blacktablet:updateCryptoBalance', function(balance)
    SendNUIMessage({
        action = "updateCryptoBalance",
        balance = balance
    })
end)

-- Update market items
RegisterNetEvent('avid-blacktablet:updateMarketItems')
AddEventHandler('avid-blacktablet:updateMarketItems', function(items)
    SendNUIMessage({
        action = "updateMarketItems",
        items = items
    })
end)
