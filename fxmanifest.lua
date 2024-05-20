fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.0.0'

shared_scripts {
    "@ox_lib/init.lua",
    "config.lua",
    "strings.lua"
}

client_scripts {
    "bridge/client.lua",
    "client/function.lua",
    "client/main.lua"
}

server_scripts {
    "bridge/server.lua",
    "server/*.lua"
}