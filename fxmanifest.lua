fx_version 'cerulean'
game 'gta5'
author 'S & Cap'
lua54 'yes'

shared_script '@ox_lib/init.lua'

files {
    'sound.html',
    'sounds/*.mp3',
}

ui_page 'sound.html'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
    'config.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    'server.lua'
}