if GetResourceState('es_extended') == 'started' then
    ESX = exports['es_extended']:getSharedObject()
    Framework = 'esx'
elseif GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
    Framework = 'qb'
end

RegisterServerEvent('snow_location:eventMoney', function(data)
    local _source = source
    if Framework == 'esx' then
        xPlayer = ESX.GetPlayerFromId(_source)
    elseif Framework == 'qb' then
        xPlayer = QBCore.Functions.GetPlayer(_source)
    end

    local model = data.model
    local price = data.price
    local spawn_coords = data.spawn_coords
    local spawn_heading = data.spawn_heading
    
    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        TriggerEvent('snow_location:spawnVehicle', _source, model, spawn_coords, spawn_heading)
        TriggerClientEvent('snow_location:updateHaveVehicle', _source, true)
    else
        TriggerClientEvent('snow_location:updateHaveVehicle', _source, false)
        TriggerClientEvent("ox_lib:notify", _source, {
            title = Strings.Notify.notEnoughMoney.title,
            description = Strings.Notify.notEnoughMoney.description,
            type = "error"
        })
    end
end)

RegisterServerEvent('snow_location:spawnVehicle', function (source, model, spawn_coords, spawn_heading)
    print("Event 'snow_location:spawnVehicle' triggered")

    vehicle = CreateVehicle(model, spawn_coords, spawn_heading, true, false)

    if vehicle == nil then
        print("Failed to create vehicle")
        return
    end

    if ConfigShared.Plate.Active == true then
        SetVehicleNumberPlateText(vehicle, ConfigShared.Plate.PlateText)
    end

    if ConfigShared.SpawnInVehicle == true then
        SetPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
    end

    TriggerClientEvent("ox_lib:notify", -1, {
        title = Strings.Notify.vehicleSpawn.title,
        description = Strings.Notify.vehicleSpawn.description,
        type = "info"
    })

    TriggerClientEvent('snow_location:updateHaveVehicle', source, true)
    TriggerClientEvent('snow_location:viewTime', source)
end)
function IsValidEntity(entity)
    return entity ~= nil and DoesEntityExist(entity)
end

RegisterServerEvent('snow_location:removeVehicle', function ()
    if IsValidEntity(vehicle) then
        SetVehicleDoorsLocked(vehicle, 2)
        FreezeEntityPosition(vehicle, true)
        TriggerClientEvent("ox_lib:notify", -1, {
            title = Strings.Notify.beforeDelete.title,
            description = Strings.Notify.beforeDelete.description,
            type = "info",
            duration = 5000
        })
        SetTimeout(2 * 60 * 1000, function ()
            if IsValidEntity(vehicle) then
                DeleteEntity(vehicle)
                TriggerClientEvent("ox_lib:notify", -1, {
                    title = Strings.Notify.vehicleDelete.title,
                    description = Strings.Notify.vehicleDelete.description,
                    type = "info"
                })
            end
        end)
    else
        return;
    end
end)