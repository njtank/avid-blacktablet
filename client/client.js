const openTablet = () => {
    SendNUIMessage({
        action: 'open',
    });
    SetNuiFocus(true, true);
}

const closeTablet = () => {
    SendNUIMessage({
        action: 'close',
    });
    SetNuiFocus(false, false);
}

// Handle crypto transfer from client to server
const transferCrypto = (amount, playerId) => {
    emit('avid-blacktablet:transferCrypto', amount, playerId);
}

// Get market items from server and display them in the UI
const fetchMarketItems = () => {
    emit('avid-blacktablet:getMarketItems');
}

// Handle item purchase from client to server
const buyItem = (itemId) => {
    emit('avid-blacktablet:buyItem', itemId);
}

// Open tablet when a key is pressed (example: "TAB" key)
RegisterCommand('openTablet', () => {
    openTablet();
}, false);

// Close tablet when escape key is pressed
RegisterCommand('closeTablet', () => {
    closeTablet();
}, false);

// Listen for NUI callback events to update UI
window.addEventListener("message", function(event) {
    const data = event.data;
    switch (data.action) {
        case "updateCryptoBalance":
            // Update crypto balance in the UI
            SetNuiFocus(true, true);
            SendNUIMessage({
                action: "updateCryptoBalance",
                balance: data.balance
            });
            break;
        case "updateMarketItems":
            // Update market items in the UI
            SendNUIMessage({
                action: "updateMarketItems",
                items: data.items
            });
            break;
        case "open":
            openTablet();
            break;
        case "close":
            closeTablet();
            break;
    }
});

// Listen for server events
onNet('avid-blacktablet:updateCryptoBalance', (newBalance) => {
    SendNUIMessage({
        action: 'updateCryptoBalance',
        balance: newBalance,
    });
});

onNet('avid-blacktablet:updateMarketItems', (items) => {
    SendNUIMessage({
        action: 'updateMarketItems',
        items: items,
    });
});

// Handle item purchase event from the server
onNet('avid-blacktablet:purchaseItem', (itemId) => {
    buyItem(itemId);
});

// Handle crypto transfer event from the server
onNet('avid-blacktablet:transferCrypto', (amount, playerId) => {
    transferCrypto(amount, playerId);
});
