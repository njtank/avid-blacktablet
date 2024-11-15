function openTab(tabName) {
    const tabs = document.querySelectorAll('.tab-content');
    tabs.forEach(tab => tab.style.display = 'none');
    
    document.getElementById(tabName).style.display = 'block';
}

// Initialize by showing the Black Market tab
document.addEventListener('DOMContentLoaded', () => openTab('market'));

// Handle dynamic crypto name
let cryptoName = 'doge';  // Default value

function loadMarketItems() {
    fetch('https://avid-blacktablet/getMarketItems', {
        method: 'POST'
    })
    .then(response => response.json())
    .then(data => {
        const marketItems = document.getElementById('market-items');
        marketItems.innerHTML = '';  // Clear previous items
        
        data.forEach(item => {
            const itemElement = document.createElement('div');
            itemElement.className = 'market-item';
            itemElement.innerHTML = `
                <h3>${item.label}</h3>
                <p>Price: ${item.price} ${cryptoName}</p>
                <button onclick="purchaseItem('${item.id}')">Buy</button>
            `;
            marketItems.appendChild(itemElement);
        });
    });
}

function createGang() {
    const gangName = document.getElementById('gang-name').value;
    const gangAbbreviation = document.getElementById('gang-abbreviation').value.toUpperCase();
    const gangColor = document.getElementById('gang-color').value;

    fetch('https://avid-blacktablet/createGang', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            name: gangName,
            abbreviation: gangAbbreviation,
            color: gangColor
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Gang created successfully!');
            document.getElementById('gang-upgrades').style.display = 'block';
        } else {
            alert('Error creating gang: ' + data.error);
        }
    });
}

function upgradeSlots() {
    fetch('https://avid-blacktablet/upgradeGangSlots', {
        method: 'POST'
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Slot added successfully!');
        } else {
            alert('Error upgrading slots: ' + data.error);
        }
    });
}

function purchaseItem(itemId) {
    fetch(`https://avid-blacktablet/purchaseItem`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ itemId })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Purchase successful!');
            loadMarketItems(); // Reload items
        } else {
            alert('Purchase failed: ' + data.error);
        }
    });
}

// Listen for the crypto name from the server
window.addEventListener('message', function(event) {
    if (event.data.action === 'openTablet') {
        cryptoName = event.data.cryptoName;  // Get crypto name from the server
        loadMarketItems();  // Load items after setting crypto name
    }
});
