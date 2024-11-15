local blackMarketListings = {}

-- Get player's crypto balance
RegisterNetEvent('crypto:getBalance', function()
    local src = source
    local balance = GetPlayerCryptoBalance(src)
    TriggerClientEvent('crypto:receiveBalance', src, balance)
end)

-- Handle black market listings
RegisterNetEvent('blackMarket:getListings', function()
    local src = source
    TriggerClientEvent('blackMarket:sendListings', src, blackMarketListings)
end)

RegisterNetEvent('blackMarket:createListing', function(data)
    local src = source
    local playerIdentifier = GetPlayerIdentifier(src)

    -- Validate item exists in the inventory and remove it
    if exports.ox_inventory:RemoveItem(src, data.item, tonumber(data.quantity)) then
        local listingId = #blackMarketListings + 1
        table.insert(blackMarketListings, {
            id = listingId,
            seller = playerIdentifier,
            item = data.item,
            quantity = tonumber(data.quantity),
            price = tonumber(data.price)
        })
        TriggerClientEvent('chat:addMessage', src, { args = { 'Black Market', 'Listing created!' } })
    else
        TriggerClientEvent('chat:addMessage', src, { args = { 'Black Market', 'Item could not be removed.' } })
    end
end)

RegisterNetEvent('blackMarket:purchaseItem', function(listingId)
    local src = source
    local listing = blackMarketListings[listingId]

    if listing then
        if RemovePlayerCrypto(src, listing.price) then
            if exports.ox_inventory:AddItem(src, listing.item, listing.quantity) then
                TriggerClientEvent('chat:addMessage', src, { args = { 'Black Market', 'Purchase successful!' } })
                blackMarketListings[listingId] = nil
            else
                -- Refund the crypto if item cannot be added
                AddPlayerCrypto(src, listing.price)
                TriggerClientEvent('chat:addMessage', src, { args = { 'Black Market', 'Failed to add item to inventory. Crypto refunded.' } })
            end
        else
            TriggerClientEvent('chat:addMessage', src, { args = { 'Black Market', 'Insufficient funds.' } })
        end
    else
        TriggerClientEvent('chat:addMessage', src, { args = { 'Black Market', 'Listing not found.' } })
    end
end)
