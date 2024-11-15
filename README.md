![Avid_RP_No_Text-removebg-preview](https://github.com/user-attachments/assets/994e90fc-d826-47b0-a499-a3a7bec6a54c)

# Avid BlackTablet

**Avid BlackTablet** is a custom resource for FiveM that introduces a tablet interface for in-game criminal activities. This tablet serves as a hub for managing black market purchases, gang creation and management, and more. All transactions are made using cryptocurrency, and users can create and upgrade gangs, set headquarters, and manage their members.

---

## Features

- **Black Market**: 
  - Buy in-game items with cryptocurrency.
  - View market listings and make purchases directly from the tablet.
  
- **Gang Management**:
  - Create a gang using the tablet.
  - Set your gang's name, abbreviation, color, and more.
  - Add up to 8 members to start (upgradeable up to 22 members using cryptocurrency).

- **Headquarters Location**:
  - Each gang has a headquarters that is shown on the tablet’s map, marked with a color-coded circle and gang abbreviation.

- **Crypto Transactions**:
  - Uses cryptocurrency (default: Doge) for all transactions within the tablet.
  - Purchase items, create gangs, and upgrade gang slots using crypto.

- **Responsive UI**:
  - Clean, modern, and user-friendly interface that mimics a tablet-like experience.

---
## Dependicies 
- ox_inventory (https://github.com/overextended/ox_inventory)
- oxmysql (https://github.com/overextended/oxmysql)


## Installation

## Add Item to ox_inventory
```lua
['black_tablet'] = {
    label = 'Black Tablet',
    weight = 500,  -- Weight of the item (grams)
    stack = false, -- This item cannot stack
    close = true,  -- Closes inventory upon use
    description = 'A tablet for accessing underground networks and managing gang activities.',
    client = {
      image = 'black_tablet.png',
    },
},
```

---
### Steps to Install:
1. Download the **avid-blacktablet** resource.
2. Place the `avid-blacktablet` folder inside your server's `resources` directory.
3. In your `server.cfg` file, add the following line:
   ```bash
   ensure avid-blacktablet
4. Install SQL file 
5. Restart server

## Events:
TriggerEvent('avid-blacktablet:openBlackTablet')
TriggerServerEvent("gang:heistCompleted", gangName) -- Adding gang rep for heist completion
TriggerServerEvent("gang:memberArrested", gangName) -- Removing rep for gang member upon arrest