fx_version 'cerulean'
game 'gta5'

author 'njtank'
description 'Avid Black Tablet'
version '1.0.0'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

client_scripts {
    'client/client.lua',
    'client/script.js'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js'
}
