fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'krucy bombiarz'
description 'System zlecen pod SanValleyRP'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}