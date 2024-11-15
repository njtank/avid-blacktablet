RegisterCommand('openBlackTablet', function()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'openTablet' })
end, false)

RegisterNUICallback('closeTablet', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)
