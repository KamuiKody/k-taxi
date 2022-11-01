lua54 'yes'
fx_version 'cerulean'
game 'gta5'

description 'K-Taxi'

ui_page 'html/index.html'

shared_script 'config.lua'

client_scripts { 
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

files {
    'html/style.css',
    'html/index.html',
    'html/script.js',
}

escrow_ignore {
    'html/style.css',
    '*.lua',
    'config.lua',
    'client/*.lua'
}