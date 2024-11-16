document.addEventListener("DOMContentLoaded", () => {
    const closeBtn = document.getElementById("close-tablet-btn");
    const marketGrid = document.querySelector(".market-grid");
    const cryptoBalanceSpan = document.getElementById("crypto-balance");

    const transferBtn = document.getElementById("transfer-btn");
    const transferAmountInput = document.getElementById("transfer-amount");
    const transferIdInput = document.getElementById("transfer-id");

    // Close tablet event
    closeBtn.addEventListener("click", () => {
        fetch('https://avid-blacktablet/closeTablet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        });
    });

    // Handle Transfer Crypto
    transferBtn.addEventListener("click", () => {
        const amount = transferAmountInput.value;
        const playerId = transferIdInput.value;

        if (amount && playerId) {
            fetch('https://avid-blacktablet/transferCrypto', {
                method: 'POST',
                body: JSON.stringify({
                    amount: amount,
                    playerId: playerId
                }),
                headers: { 'Content-Type': 'application/json' },
            }).then(response => response.json()).then(data => {
                if (data.success) {
                    alert("Crypto transferred successfully!");
                    updateCryptoBalance(data.newBalance);
                } else {
                    alert("Error transferring crypto.");
                }
            });
        }
    });

    // Update market items in the grid
    function updateMarketItems(items) {
        marketGrid.innerHTML = '';  // Clear the market grid

        items.forEach(item => {
            const itemElement = document.createElement('div');
            itemElement.classList.add('market-item');
            itemElement.innerHTML = `
                <img class="item-image" src="${item.image || 'default.png'}" alt="${item.name}" />
                <div class="item-name">${item.name}</div>
                <div class="item-price">${item.price} Doge</div>
                <button class="buy-btn">Buy</button>
            `;

            // Add event listener to the buy button
            itemElement.querySelector('.buy-btn').addEventListener('click', () => {
                buyItem(item.id);
            });

            marketGrid.appendChild(itemElement);
        });
    }

    // Trigger purchase item event
    function buyItem(itemId) {
        fetch('https://avid-blacktablet/buyItem', {
            method: 'POST',
            body: JSON.stringify({ itemId: itemId }),
            headers: { 'Content-Type': 'application/json' },
        }).then(response => response.json()).then(data => {
            if (data.success) {
                alert("Item purchased successfully!");
            } else {
                alert("Not enough crypto to buy this item.");
            }
        });
    }

    // Listen for incoming messages from Lua (via NUI callback)
    window.addEventListener("message", function(event) {
        const data = event.data;

        switch (data.action) {
            case "open":
                document.getElementById('tablet').style.display = "block";
                break;
            case "close":
                document.getElementById('tablet').style.display = "none";
                break;
            case "updateCryptoBalance":
                updateCryptoBalance(data.balance);
                break;
            case "updateMarketItems":
                updateMarketItems(data.items);
                break;
        }
    });

    // Function to update the user's crypto balance
    function updateCryptoBalance(newBalance) {
        cryptoBalanceSpan.textContent = newBalance;
    }

    // Fetch market items when the tablet is opened
    fetch('https://avid-blacktablet/getMarketItems', {
        method: 'GET',
        headers: { 'Content-Type': 'application/json' }
    }).then(response => response.json()).then(data => {
        if (data.success) {
            updateMarketItems(data.items);
        } else {
            alert('No market items found.');
        }
    });
});
