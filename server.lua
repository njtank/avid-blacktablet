local ox_inventory = exports.ox_inventory

RegisterNetEvent('avid-blacktablet:getMarketItems', function()
    local source = source
    local xPlayer = ox_inventory.GetPlayer(source)

    MySQL.Async.fetchAll('SELECT * FROM black_market_listings', {}, function(results)
        local items = {}
        for _, row in ipairs(results) do
            table.insert(items, {
                id = row.id,
                label = row.item_label,
                price = row.item_price
            })
        end
        TriggerClientEvent('avid-blacktablet:receiveMarketItems', source, items)
    end)
end)

RegisterNetEvent('avid-blacktablet:purchaseItem', function(itemId)
    local source = source
    local xPlayer = ox_inventory.GetPlayer(source)

    MySQL.Async.fetchScalar('SELECT item_price, seller_id FROM black_market_listings WHERE id = @id', {
        ['@id'] = itemId
    }, function(itemPrice, sellerId)
        if xPlayer.crypto >= itemPrice then
            xPlayer.removeCrypto(itemPrice)
            ox_inventory:AddItem(source, 'your_item_name', 1)
            MySQL.Async.execute('DELETE FROM black_market_listings WHERE id = @id', { ['@id'] = itemId })
        else
            TriggerClientEvent('avid-blacktablet:notify', source, 'Not enough crypto!')
        end
    end)
end)

RegisterNetEvent('avid-blacktablet:createGang', function(data)
    local source = source
    local xPlayer = ox_inventory.GetPlayer(source)

    if xPlayer.crypto >= 500 then
        xPlayer.removeCrypto(500)

        local gangId = MySQL.Async.insert('INSERT INTO gangs (name, abbreviation, color, leader_id, headquarters_x, headquarters_y, headquarters_z, member_slots) VALUES (@name, @abbreviation, @color, @leader, @x, @y, @z, 8)', {
            ['@name'] = data.name,
            ['@abbreviation'] = data.abbreviation,
            ['@color'] = data.color,
            ['@leader'] = xPlayer.identifier,
            ['@x'] = data.x,
            ['@y'] = data.y,
            ['@z'] = data.z
        })

        TriggerClientEvent('avid-blacktablet:notify', source, 'Gang created successfully!')
    else
        TriggerClientEvent('avid-blacktablet:notify', source, 'Not enough crypto!')
    end
end)

RegisterNetEvent('avid-blacktablet:upgradeGangSlots', function()
    local source = source
    local xPlayer = ox_inventory.GetPlayer(source)

    if xPlayer.crypto >= 200 then
        xPlayer.removeCrypto(200)

        MySQL.Async.execute('UPDATE gangs SET member_slots = member_slots + 1 WHERE leader_id = @leader_id', {
            ['@leader_id'] = xPlayer.identifier
        })

        TriggerClientEvent('avid-blacktablet:notify', source, 'Slot added successfully!')
    else
        TriggerClientEvent('avid-blacktablet:notify', source, 'Not enough crypto!')
    end
end)
