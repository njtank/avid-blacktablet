** WIP, use at your own risk, because well, it doesnt work **


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
``` Open Black Tablet
TriggerEvent('avid-blacktablet:openBlackTablet')
```
``` Adding gang rep for heist completion
TriggerServerEvent("gang:heistCompleted", gangName)
```
``` Removing rep for gang member upon arrest
TriggerServerEvent("gang:memberArrested", gangName)
```

## Future Updates:  
- **Crypto Wallets** - The ability to hack other players' crypto wallets via a mini-game.  
- **Police Database Access** - For a certain amount of crypto, a player may be able to attack the MDT service (PS-MDT) to shut down the system and/or remove their most recent crime.  
- **Heist Planning App** - Ability to assign roles to gang members, set waypoints for planning, and purchase heist-specific items.  
- **Territory War System** - Real-time updates of territory gained or lost, with benefits to owning more territory, such as increased crypto yield on heists.    
- **Custom HQ Upgrades** - Ability to add storage units, custom security (cameras, reinforced doors, etc.), and functional items like a crafting bench.  
- **Communication Tools** - Encrypted messaging between gang members.  
- **Document Forgery** - Create fake license plates and driver's licenses.  
