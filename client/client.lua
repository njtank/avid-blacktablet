-- Function to open the tablet UI
function openBlackTablet()
    SetNuiFocus(true, true)
    SendNUIMessage({ 
        action = 'openTablet',
        cryptoName = Config.CryptoName -- Send the crypto name to the UI
    })
end

-- Function to close the tablet UI
function closeBlackTablet()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'closeTablet' })
end

-- NUI callback for closing the tablet from within the UI
RegisterNUICallback('closeTablet', function(data, cb)
    closeBlackTablet()
    cb('ok')
end)

-- Example trigger for testing purposes (Optional)
-- This can be removed if you only want the functions to be called externally
RegisterNetEvent('avid-blacktablet:openTablet')
AddEventHandler('avid-blacktablet:openTablet', function()
    openBlackTablet()
end)

RegisterNetEvent('ox_inventory:useItem', function(item)
    if item.name == 'black_tablet' then
        TriggerEvent('avid-blacktablet:openBlackTablet') -- Opens the Black Tablet UI
    end
end)

