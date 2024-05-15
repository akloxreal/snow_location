TargetAdd = function (ped, locationId)
    exports.ox_target:addLocalEntity(ped, {
        name = "location_"..locationId,
        label = "Location - " .. locationId:gsub("^%l", string.upper),
        icon = "fas fa-car",
        distance = 20.0,
        onSelect = function ()
            if ConfigShared.Debug then
                print("Selected location point: " .. locationId)
            end
            OpenLocationMenu(locationId)
        end
    })

    if ConfigShared.Debug then
        print("Added location point: " .. locationId)
    end
end

TargetRemove = function (ped, locationId)
    exports.ox_target:removeLocalEntity(ped, locationId)
    if ConfigShared.Debug then
        print("Removed location point: " .. locationId)
    end
end

RegisterNetEvent("snow_location:viewTime", function (source)
    local time = ConfigShared.VehicleTimeout

    while time > 0 and haveVehicle do
        Wait(1000)
        time = time - 1
        local minutes = time // 60
        local seconds = time % 60

        local formatedTime = ("%02d:%02d"):format(minutes, seconds)
        lib.showTextUI((Strings.Notify.remainingTime):format(formatedTime))
    
        local timer = lib.waitFor(function ()
            if time == 0 or not haveVehicle then
                return true
            else
                return false
            end
        end, "Timeout reached before vehicle was removed", time * 1000 * 2)  -- Double the timeout
    
        if timer then
            haveVehicle = false
            lib.hideTextUI()
            TriggerServerEvent('snow_location:removeVehicle')
        end
    end
end)

function DeleteTimeAndVehicle()
    haveVehicle = false
    lib.hideTextUI()
    local coords = GetEntityCoords(PlayerPedId())
    local vehicle = lib.getClosestVehicle(coords, 10.0, false)
    DeleteEntity(vehicle)

    lib.notify({
        title = Strings.Notify.vehicleDelete.title,
        description = Strings.Notify.vehicleDelete.description,
        type = "info"
    })
end

RegisterNetEvent('snow_location:updateHaveVehicle', function(value)
    haveVehicle = value
end)