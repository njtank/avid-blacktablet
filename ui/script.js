let currentPage = 'home';
let historyStack = [];

/**
 * Go back to the previous page.
 */
function goBack() {
    if (historyStack.length > 0) {
        currentPage = historyStack.pop();
        loadPage(currentPage, false);
    }
}

/**
 * Load a new page into the tablet.
 * @param {string} page - The page to load.
 * @param {boolean} addToHistory - Whether to add this page to the history stack.
 */
function loadPage(page, addToHistory = true) {
    if (addToHistory) historyStack.push(currentPage);
    currentPage = page;

    const content = document.getElementById('content');
    content.innerHTML = ''; // Clear existing content

    switch (page) {
        case 'blackMarket':
            content.innerHTML = `<h2>Black Market</h2>
                <p>Explore and create listings of exclusive items.</p>
                <button class="button" onclick="loadPage('createListing')">Create Listing</button>
                <button class="button" onclick="loadPage('browseListings')">Browse Listings</button>`;
            break;
        case 'createListing':
            content.innerHTML = `<h2>Create Listing</h2>
                <form onsubmit="submitListing(event)">
                    <label for="item">Item:</label><br>
                    <input type="text" id="item" name="item"><br>
                    <label for="quantity">Quantity:</label><br>
                    <input type="number" id="quantity" name="quantity" min="1"><br>
                    <label for="price">Price (${getCryptoName()}):</label><br>
                    <input type="number" id="price" name="price" min="1"><br>
                    <button type="submit" class="button">Submit</button>
                </form>`;
            break;
        case 'browseListings':
            content.innerHTML = `<h2>Browse Listings</h2>
                <p>Loading listings...</p>`;
            fetchListings();
            break;
        case 'cryptoWallet':
            content.innerHTML = `<h2>Crypto Wallet</h2>
                <p>Your balance: <span id="cryptoBalance">Loading...</span> ${getCryptoName()}</p>`;
            fetchCryptoBalance();
            break;
        case 'gangManagement':
            content.innerHTML = `<h2>Gang Management</h2>
                <p>Manage your gang, recruit members, and upgrade slots.</p>`;
            break;
        case 'territories':
            content.innerHTML = `<h2>Territories</h2>
                <p>View your gang's territory on the map.</p>`;
            break;
        default:
            content.innerHTML = `<h2>Home</h2>`;
    }
}

/**
 * Submit a new listing to the black market.
 */
function submitListing(event) {
    event.preventDefault();

    const item = document.getElementById('item').value;
    const quantity = parseInt(document.getElementById('quantity').value);
    const price = parseInt(document.getElementById('price').value);

    fetch(`https://${GetParentResourceName()}/blackMarket:create`, {
        method: 'POST',
        body: JSON.stringify({ item, quantity, price }),
    }).then((response) => response.json())
      .then((data) => {
          if (data.success) {
              alert('Listing created successfully!');
              goBack();
          } else {
              alert(`Error: ${data.message}`);
          }
      });
}

/**
 * Fetch and display the crypto balance.
 */
function fetchCryptoBalance() {
    fetch(`https://${GetParentResourceName()}/crypto:getBalance`, {
        method: 'POST',
    }).then((response) => response.json())
      .then((data) => {
          document.getElementById('cryptoBalance').innerText = data.balance;
      });
}

/**
 * Fetch and display listings from the black market.
 */
function fetchListings() {
    fetch(`https://${GetParentResourceName()}/blackMarket:browse`, {
        method: 'POST',
    }).then((response) => response.json())
      .then((listings) => {
          const content = document.getElementById('content');
          content.innerHTML = '<h2>Browse Listings</h2>';
          listings.forEach((listing) => {
              const listingDiv = document.createElement('div');
              listingDiv.innerHTML = `<p>${listing.item} x${listing.quantity} - ${listing.price} ${getCryptoName()}</p>
                                       <button class="button" onclick="purchaseItem(${listing.id})">Buy</button>`;
              content.appendChild(listingDiv);
          });
      });
}

/**
 * Get the configured cryptocurrency name.
 * @returns {string}
 */
function getCryptoName() {
    return 'doge'; // Change dynamically if needed
}

function loadGangReputation() {
    const content = document.getElementById('content');
    content.innerHTML = '<h2>Gang Reputation</h2><div id="reputationDetails"></div>';
    fetch(`https://${GetParentResourceName()}/gang:getReputation`, {
        method: 'POST',
    }).then((response) => response.json())
      .then((reputationData) => {
          const detailsDiv = document.getElementById('reputationDetails');
          reputationData.forEach((gang) => {
              detailsDiv.innerHTML += `<div>
                  <h3>${gang.name}</h3>
                  <p>Reputation: ${gang.reputation}</p>
                  <p>Tier: ${gang.tier}</p>
              </div>`;
          });
      });
}
