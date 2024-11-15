fx_version 'cerulean'
game 'gta5'

author 'njtank'            
resource_name 'black_tablet'  
version '1.0.0'               

ui_page 'ui/tablet.html'      

files {
    'ui/tablet.html',         -- Updated the path to UI folder
    'ui/tablet.css',          -- Updated the path to UI folder
    'ui/tablet.js'            -- Updated the path to UI folder
}

-- Client Scripts
client_script 'client/client.lua'   -- Client script in the client folder
client_script 'config.lua'          

-- Server Scripts
server_script 'server/server.lua'   -- Server script in the server folder
server_script 'config.lua'          
