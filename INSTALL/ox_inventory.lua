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