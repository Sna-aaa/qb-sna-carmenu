fx_version 'cerulean'
game 'gta5'

description 'QB-CarMenu'
version '1.0.0'

client_scripts {
    '@menuv/menuv.lua',
    'client/client.lua',
}

shared_script '@qb-core/import.lua'

server_script 'server/server.lua'

dependencies {
    'menuv'
}
