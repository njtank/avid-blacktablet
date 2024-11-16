local QBCore = exports['qb-core']:GetCoreObject()

-- Add item to market
RegisterNetEvent('avid-blacktablet:addItem')
AddEventHandler('avid-blacktablet:addItem', function(data)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    -- Add the item to the market in the database
    MySQL.Async.execute('INSERT INTO market_items (name, amount, price, owner_id) VALUES (?, ?, ?, ?)', {
        data.itemName, data.itemAmount, data.itemPrice, src
    }, function()
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Item listed successfully!'})
    end)
end)

-- Get items in the market
RegisterNetEvent('avid-blacktablet:getMarketItems')
AddEventHandler('avid-blacktablet:getMarketItems', function()
    local items = MySQL.Sync.fetchAll('SELECT * FROM market_items')

    TriggerClientEvent('avid-blacktablet:updateMarketItems', source, items)
end)

-- Buy item from market
RegisterNetEvent('avid-blacktablet:buyItem')
AddEventHandler('avid-blacktablet:buyItem', function(data)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    -- Check if player has enough crypto
    local cryptoBalance = xPlayer.PlayerData.money['crypto']
    local item = MySQL.Sync.fetchAll('SELECT * FROM market_items WHERE id = ?', {data.itemId})

    if cryptoBalance >= item[1].price then
        xPlayer.Functions.RemoveMoney('crypto', item[1].price)
        -- Add item to player inventory
        xPlayer.Functions.AddItem(item[1].name, item[1].amount)

        -- Remove item from market
        MySQL.Async.execute('DELETE FROM market_items WHERE id = ?', {data.itemId})

        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Item purchased successfully!'})
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Not enough crypto!'})
    end
end)

-- Transfer crypto
RegisterNetEvent('avid-blacktablet:transferCrypto')
AddEventHandler('avid-blacktablet:transferCrypto', function(data)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    local targetPlayer = QBCore.Functions.GetPlayer(data.playerId)
    if targetPlayer then
        local transferAmount = tonumber(data.amount)

        if xPlayer.PlayerData.money['crypto'] >= transferAmount then
            xPlayer.Functions.RemoveMoney('crypto', transferAmount)
            targetPlayer.Functions.AddMoney('crypto', transferAmount)

            TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Crypto transferred successfully!'})
            TriggerClientEvent('ox_lib:notify', targetPlayer.PlayerData.source, {type = 'success', description = 'You received crypto!'})
        else
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Not enough crypto!'})
        end
    end
end)
