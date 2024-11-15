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

## Installation

### Steps to Install:
1. Download the **avid-blacktablet** resource.
2. Place the `avid-blacktablet` folder inside your server's `resources` directory.
3. In your `server.cfg` file, add the following line:
   ```bash
   ensure avid-blacktablet

## Events:
TriggerEvent('avid-blacktablet:openBlackTablet')
